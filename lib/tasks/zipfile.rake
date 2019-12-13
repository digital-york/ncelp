# To run this task, type:
# RAILS_ENV=production bundle exec rake zipfile:collections[server_url, download_folder hosted by Apache/Nginx]
# e.g. for local VM
# RAILS_ENV=production bundle exec rake zipfile:collections[http://localhost:3000/, /tmp]

namespace :zipfile do
    require 'figaro'
    require 'open-uri'
    require 'fileutils'
    require 'zip'
    require 'time'

    RESOURCE_UPDATE_CHECK_FREQUENCY = 365 * 24 * 60    # 24 hours

    SOLR = Figaro.env.solr_url.freeze
    solr = RSolr.connect :url => SOLR

    desc 'Generate zip files containing all resources for each collection'
    task :collections, [:server_url,:download_folder] => [:environment] do |task, args|
        server_url      = args[:server_url]
        download_url    = "#{server_url}downloads/"
        download_folder = args[:download_folder]

        solr_query = 'has_model_ssim:Collection'

        response = solr.get 'select', :params => {
            :q=>"#{solr_query}",
            :start=>0,
            :rows=>10000
        }
        number_of_collections = response['response']['numFound']
        if number_of_collections == 0
            Rails.logger.info 'No collection found.'
        else
            Rails.logger.info "Total collections: #{number_of_collections}"
            Rails.logger.info '------------------------------'

            response['response']['docs'].each do |doc|
                id    = doc['id']
                title = doc['title_tesim'][0]
                Rails.logger.info "  processing collection: #{title}"
                process_collection(solr, id, download_url, download_folder)
            end

        end
    end

    private
        # process a collection
        def process_collection(solr, collection_id, download_url, download_folder)
            resources_solr_query = "nesting_collection__parent_ids_ssim:#{collection_id} and has_model_ssim:Resource"
            resources_response = solr.get 'select', :params => {
                :q=>"#{resources_solr_query}",
                :start=>0,
                :rows=>10000
            }
            number_of_resources = resources_response['response']['numFound']
            if number_of_resources == 0
                Rails.logger.info '    No resource found.'
            else
                # process child resources and create zip file only when
                # The child resources have been updated
                # OR
                # The expected previous created zip file does not exist
                if updated_within?(resources_response, RESOURCE_UPDATE_CHECK_FREQUENCY) or !File.exist?("#{download_folder}/#{collection_id}.zip")
                    FileUtils.mkdir_p "/#{download_folder}/#{collection_id}"
                    Rails.logger.info "    total resources: #{number_of_resources}"
                    resources_response['response']['docs'].each do |doc|
                        id         = doc['id']
                        title      = doc['title_tesim'][0]
                        member_ids = doc['member_ids_ssim']
                        Rails.logger.info "    processing resource: #{title}"
                        process_resource(solr, collection_id, id, member_ids, download_url, download_folder)
                    end
                    unless Dir.empty?("#{download_folder}/#{collection_id}")
                        File.delete("#{download_folder}/#{collection_id}.zip") if File.exist?("#{download_folder}/#{collection_id}.zip")
                        # Create a zip file
                        create_zip(download_folder, collection_id)
                        # Delete temporary folder/files
                        FileUtils.rm_rf("#{download_folder}/#{collection_id}")
                    end
                else
                    Rails.logger.info "    no update for collection: #{collection_id}, can use previously generated zip file."
                end
            end
        end

        # Check if a collection's child resources has been updated within a certain time
        def updated_within?(resources_response, minutes)
            resources_response['response']['docs'].each do |doc|
                last_updated = Time.parse(doc['system_modified_dtsi'])
                if(((Time.now - last_updated) / 60).round <= minutes)
                    return true
                end
            end
            false
        end

        # process a Resource (work)
        def process_resource(solr, collection_id, resource_id, member_ids, download_url, download_folder)
            # Download URL: https://resources.ncelp.org/downloads/r207tp471
            member_ids.each do |id|
                begin
                    fs = FileSet.find(id)
                    filename = id
                    filename = fs.label unless fs.label.nil?
                    file_url = download_url + id
                    File.open("#{download_folder}/#{collection_id}/#{filename}", "wb") do |saved_file|
                        open(file_url, "rb") do |read_file|
                            saved_file.write(read_file.read)
                            Rails.logger.info "        saved #{filename} in #{download_folder}/#{collection_id}/"
                        end
                    end
                rescue StandardError => e
                    Rails.logger.error "        ERROR while downloading #{id}"
                    Rails.logger.error e.backtrace.inspect
                    break
                end
            end
        end

        def create_zip(download_folder, collection_id)
            zipfile_name = "#{download_folder}/#{collection_id}.zip"
            files = Dir["#{download_folder}/#{collection_id}/*"]
            Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
                files.each do |filename|
                    zipfile.add(File.basename(filename), filename)
                end
            end
            Rails.logger.info "    created #{zipfile_name}"
        end

end