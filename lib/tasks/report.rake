# To run this task, type:
# RAILS_ENV=production bundle exec rake report:downloader_per_status

namespace :report do
    require 'figaro'
    require 'date'
    require 'mail'
    require_relative 'file_desc'

    SOLR = Figaro.env.solr_url

    # define status value to desc map
    STATUS_MAP = {
        'language_learner'                  => 'Language learner',
        'language_teacher'                  => 'Language teacher/instructor',
        'language_teacher_pre_elementary'   => 'Pre-elementary / kindergarten',
        'language_teacher_primary'          => 'Primary school',
        'language_teacher_secondary'        => 'Secondary / high school',
        'language_teacher_tertiary'         => 'Tertiary / university',
        'language_teacher_adult_edu'        => 'Adult education',
        'language_teacher_private'          => 'Private institution',
        'language_teacher_other'            => 'Other teacher',
        'materials_developer'               => 'Materials / curriculum developer',
        'media'                             => 'Media / journalist',
        'ncelp_specialist_teacher'          => 'NCELP Specialist Teacher',
        'ncelp_hub_school_teacher'          => 'NCELP Hub School Teacher',
        'parent'                            => 'Parent',
        'policy_maker'                      => 'Policy maker',
        'professional_development_provider' => 'Professional development provider',
        'student'                           => 'Student',
        'undergraduate'                     => 'Undergraduate',
        'masters'                           => 'Masters',
        'phd'                               => 'PhD',
        'other'                             => 'Other student',
        'teacher_educator'                  => 'Teacher educator',
        'test_developer'                    => 'Test developer',
        'university_academic'               => 'University academic',
        'early_career'                      => 'Early career',
        'mid_career'                        => 'Mid-career',
        'established_scholar'               => 'Established scholar'
    }.freeze

    # define parent status type map
    STATUS_PARENT_MAP = {
        'language_teacher_pre_elementary'   => 'language_teacher',
        'language_teacher_primary'          => 'language_teacher',
        'language_teacher_secondary'        => 'language_teacher',
        'language_teacher_tertiary'         => 'language_teacher',
        'language_teacher_adult_edu'        => 'language_teacher',
        'language_teacher_private'          => 'language_teacher',
        'language_teacher_other'            => 'language_teacher',
        'undergraduate'                     => 'student',
        'masters'                           => 'student',
        'phd'                               => 'student',
        'other'                             => 'student',
        'early_career'                      => 'university_academic',
        'mid_career'                        => 'university_academic',
        'established_scholar'               => 'university_academic'
    }.freeze

    desc 'Generate downloader statistics per status'
    task :downloader_per_status => :environment do
        results = {}

        solr_query = 'has_model_ssim:Downloader'
        solr = RSolr.connect :url => SOLR
        response = solr.get 'select', :params => {
            :q=>"#{solr_query}",
            :start=>0,
            :rows=>2147483647
        }
        number_of_downloaders = response['response']['numFound']
        if number_of_downloaders == 0
            puts 'No downloader found.'
        else
            puts "Total downloads: #{number_of_downloaders}"
            puts '------------------------------'

            response['response']['docs'].each do |doc|
                current_doc_status = {}
                unless doc['downloader_status_tesim'].nil?
                    doc['downloader_status_tesim'].each do |status|
                        # if current status is top level status
                        if STATUS_PARENT_MAP[status].nil?
                            current_doc_status[status] = 1
                        else
                            # if current status has a parent status, store its parent status
                            current_doc_status[STATUS_PARENT_MAP[status]] = 1
                        end
                    end
                    unless current_doc_status.length == 0
                        current_doc_status.keys.each do |status|
                            if results[status].nil?
                                results[status] = 1
                            else
                                results[status] = results[status] + 1
                            end
                        end
                    end
                end
            end

            results.each do |k,v|
                puts "#{STATUS_MAP[k]}, #{v}"
            end
        end
    end

    # bundle exec rake report:downloader_per_email
    desc 'Generate downloader statistics per email'
    task :downloader_per_email => :environment do
        results = {}

        solr_query = 'has_model_ssim:Downloader'
        solr = RSolr.connect :url => SOLR
        response = solr.get 'select', :params => {
            :q=>"#{solr_query}",
            :start=>0,
            :rows=>2147483647
        }
        number_of_downloaders = response['response']['numFound']
        if number_of_downloaders == 0
            puts 'No downloader found.'
        else
            puts "Total downloads: #{number_of_downloaders}"
            puts '------------------------------'

            response['response']['docs'].each do |doc|
                unless doc['downloader_email_tesim'].nil?
                    doc['downloader_email_tesim'].each do |email|
                        if results[email].blank?
                            results[email] = 1
                        else
                            results[email] = results[email] + 1
                        end
                    end
                end
            end

            results.each do |k,v|
                puts "#{k}, #{v}"
            end
        end
    end

    # bundle exec rake report:downloader_per_country
    desc 'Generate downloader statistics per country'
    task :downloader_per_country => :environment do
        results = {}

        solr_query = 'has_model_ssim:Downloader'
        solr = RSolr.connect :url => SOLR
        response = solr.get 'select', :params => {
            :q=>"#{solr_query}",
            :start=>0,
            :rows=>2147483647
        }
        number_of_downloaders = response['response']['numFound']
        if number_of_downloaders == 0
            puts 'No downloader found.'
        else
            puts "Total downloads: #{number_of_downloaders}"
            puts '------------------------------'

            response['response']['docs'].each do |doc|
                unless doc['participants_country_tesim'].nil?
                    doc['participants_country_tesim'].each do |country|
                        if results[country].blank?
                            results[country] = 1
                        else
                            results[country] = results[country] + 1
                        end
                    end
                end
            end

            results.each do |k,v|
                puts "#{k}, #{v}"
            end
        end
    end

    desc 'Generate downloader statistics per month'
    task :downloader_per_month => :environment do
        results = {}

        solr_query = 'has_model_ssim:Downloader'
        solr = RSolr.connect :url => SOLR
        response = solr.get 'select', :params => {
            :q=>"#{solr_query}",
            :start=>0,
            :rows=>2147483647
        }
        number_of_downloaders = response['response']['numFound']
        if number_of_downloaders == 0
            puts 'No downloader found.'
        else
            puts "Total downloads: #{number_of_downloaders}"
            puts '------------------------------'

            response['response']['docs'].each do |doc|
                download_time = Date.parse(doc['system_create_dtsi']).strftime("%Y.%m")
                if results[download_time].nil?
                    results[download_time] = 1
                else
                    results[download_time] = results[download_time] + 1
                end
            end

            results.each do |k,v|
                puts "#{k} => #{v}"
            end
        end
    end

    # RAILS_ENV=production bundle exec rake report:files[/tmp/ncelp_files.html,https://resources.ldpedagogy.org,7]
    # The rake task takes 3 parameters:
    # The first one is the output file name
    # The second one is the base URL
    # The third one is the number of days from now. The file must be uploaded within these days.
    desc 'Generate file report'
    task :files, [:csv_filename,:base_url,:days]  => :environment do |t, args|
        csv = args[:csv_filename]
        base_url = args[:base_url]
        days = args[:days].to_i
        filedesc_array = []

        solr_query = 'has_model_ssim:Resource'
        solr = RSolr.connect :url => SOLR
        response = solr.get 'select', :params => {
            :q=>"#{solr_query}",
            :start=>0,
            :rows=>2147483647
        }
        number_of_resources = response['response']['numFound']
        if number_of_resources == 0
            puts 'No resource found.'
        else
            puts "Total resources: #{number_of_resources}"
            puts '------------------------------'

            i = 1

            response['response']['docs'].each do |doc|
                puts "Analysing [#{i} / #{number_of_resources}]"
                resource_id = doc['id']
                resource_title = ''
                resource_title = doc['title_tesim'][0] unless doc['title_tesim'].blank?
                resource_create_date = Date.parse(doc['date_uploaded_dtsi'])
                collection_id = doc['member_of_collection_ids_ssim'][0] unless doc['member_of_collection_ids_ssim'].blank?
                fileset_ids = doc['file_set_ids_ssim']
                unless fileset_ids.blank?
                    fileset_ids.each do |fileset_id|
                        begin
                            fs = FileSet.find(fileset_id)
                            # ignore files created before days from now
                            if Date.today - days > fs.date_modified
                                next
                            end

                            fileset_title = ''
                            fileset_title = fs.title[0] unless fs.title.blank?
                            collection_title = ''
                            unless collection_id.blank?
                                c = Collection.find(collection_id)
                                collection_title = c.title[0]
                            end
                            fd = FileDesc.new(collection_id,
                                              collection_title,
                                              resource_id,
                                              resource_title,
                                              resource_create_date,
                                              fileset_id,
                                              fileset_title,
                                              fs.date_uploaded,
                                              fs.creator[0])
                            filedesc_array << fd
                        rescue
                            puts '  ERROR'
                        end
                    end
                end
                i = i + 1
            end

            #filedesc_array.sort!.reverse
            filedesc_array.sort!

            results = []
            results << "<meta charset=\"UTF-8\">"
            results << "<table>"
            results << "<tr>"
            results << "<td width=\"20%\">Collection</td>"
            results << "<td width=\"10%\">Resource date</td>"
            results << "<td width=\"20%\">Resource</td>"
            results << "<td width=\"20%\">File</td>"
            results << "<td width=\"10%\">File date</td>"
            results << "<td width=\"20%\">Depositor</td>"
            results << "</tr>"
            filedesc_array.each do |fd|
                collection_column = ''
                unless fd.collection_id.blank?
                    collection_column = "<a href=\"#{base_url}/collections/#{fd.collection_id}\">#{fd.collection_title}</a>"
                end
                fs_column = "<a href=\"#{base_url}/concern/parent/#{fd.resource_id}/file_sets/#{fd.fileset_id}\">#{fd.fileset_title}</a>"
                resource_column = "<a href=\"#{base_url}/concern/resources/#{fd.resource_id}\">#{fd.resource_title}</a>"

                results << "<tr>"
                results << "<td width=\"20%\">#{collection_column}</td>"
                results << "<td width=\"10%\">" + fd.resource_date.strftime("%Y-%m-%d %H:%M:%S")+"</td>"
                results << "<td width=\"20%\">#{resource_column}</td>"
                results << "<td width=\"20%\">#{fs_column}</td>"
                results << "<td width=\"10%\">" + fd.fileset_date.strftime("%Y-%m-%d %H:%M:%S")+"</td>"
                results << "<td width=\"20%\">#{fd.depositor}</td>"
                results << "</tr>"
            end
            results << "</table>"
            File.open(csv, "w:UTF-8") do |f|
                results.each { |line| f.puts(line) }
            end
        end
    end

    # RAILS_ENV=production RUBYOPT=-W0 bundle exec rake report:mailout[/tmp/ncelp_files.html]
    # email
    desc 'Send out NCELP weely digests'
    task :mailout, [:html_filename]  => :environment do |t, args|
        html_filename = args[:html_filename]

        date_to = Date.today
        date_from = (date_to - 7)

        Figaro.env.mail_sender

        options = { :address              => Figaro.env.mail_server,
                    :port                 => Figaro.env.mail_port.to_i,
                    :user_name            => Figaro.env.mail_sender,
                    :password             => Figaro.env.mail_sender_password,
                    :authentication       => 'plain',
                    :enable_starttls_auto => true
        }

        Mail.defaults do
            delivery_method :smtp, options
        end

        Mail.deliver do
            from Figaro.env.mail_sender
            to Figaro.env.mail_recipients
            subject "#{Figaro.env.mail_weekly_digests_subject} #{date_from} / #{date_to}"
            body "#{Figaro.env.mail_weekly_digests_subject} #{date_from} / #{date_to}"
            add_file html_filename
        end
    end

    # RAILS_ENV=production RUBYOPT=-W0 bundle exec rake report:list_collection
    desc 'list all collections'
    task :list_collection => :environment do

        i=1
        Collection.all.each { |c|
            puts i.to_s + ":" + c.id + ":" + c.title[0]
            i = i+1
        }
    end
end