# To run this task, type:
# RAILS_ENV=production bundle exec rake report:downloader_per_status

namespace :report do
    require 'figaro'
    require 'json'
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
                puts "#{STATUS_MAP[k]} => #{v}"
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

    # RAILS_ENV=production bundle exec rake report:files[/tmp/ncelp_files.html,https://resources.ncelp.org,7]
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

    desc 'Generate download statistics and save to json'
    # bundle exec report:download_stats_json[/tmp/]
    task :download_stats_json, [:output_folder] => [:environment] do |t, args|
        output_folder = args[:output_folder]

        # general - total resources
        downloads_total                = {}
        downloads_total_file           = output_folder + 'downloads_total.json'

        # general - total downloads & downloads over time
        downloads_per_day                = {}
        downloads_per_day_file           = output_folder + 'downloads_per_day.json'

        # download by survey fields - status
        downloads_per_status             = {}
        downloads_per_status_file        = output_folder + 'downloads_per_status.json'

        # download per material type
        downloads_per_material_type      = {}
        downloads_per_material_type_file = output_folder + 'downloads_per_material_type.json'

        # download per age
        downloads_per_age      = {}
        downloads_per_age_file = output_folder + 'downloads_per_age.json'

        # download per Pedagogical focus
        downloads_per_pedagogical_focus      = {}
        downloads_per_pedagogical_focus_file = output_folder + 'downloads_per_pedagogical_focus.json'

        # download per language
        downloads_per_language           = {}
        downloads_per_language_file      = output_folder + 'downloads_per_language.json'

        # download per materials for teacher(CPD, SOW etc)
        downloads_per_material_for_teacher           = {}
        downloads_per_material_for_teacher_file      = output_folder + 'downloads_per_material_for_teacher.json'

        # download per resource
        downloads_per_resource           = {}
        downloads_per_resource_file      = output_folder + 'downloads_per_resource.json'
        resource_titles                  = {}
        resource_titles_file             = output_folder + 'resource_titles.json'

        # general - total resources
        record_downloads_total(downloads_total)

        solr_docs = get_solr_doc('has_model_ssim:Downloader')
        if solr_docs == '{}'
            puts 'No download found.'
        else
            solr_docs.each do |doc|
                # general - total downloads & downloads over time
                record_downloads_per_day(doc, downloads_per_day)

                # download by survey fields - status
                record_downloads_per_status(doc, downloads_per_status)

                resource_id  = doc['isPartOf_ssim'][0]
                resource_doc = get_solr_doc("id:#{resource_id}")[0]

                # download per material type
                record_downloads_per_material_type(resource_doc, downloads_per_material_type)

                # download per age
                record_downloads_per_age(resource_doc, downloads_per_age)

                # download per Pedagogical focus
                record_downloads_per_pedagogical_focus(resource_doc, downloads_per_pedagogical_focus)

                # download per language
                record_downloads_per_language(resource_doc, downloads_per_language)

                # download per materials for teacher(CPD, SOW etc)
                record_downloads_per_material_for_teacher(resource_doc, downloads_per_material_for_teacher)

                # download per resource
                record_downloads_per_resource(resource_doc, downloads_per_resource, resource_titles)
            end

            # Save results to jsons
            # general - total resources
            save_to_json(downloads_total, downloads_total_file)

            # general - total downloads & downloads over time
            save_to_json(downloads_per_day, downloads_per_day_file)

            # download by survey fields - status
            save_to_json(downloads_per_status, downloads_per_status_file)

            # download per material type
            save_to_json(downloads_per_material_type, downloads_per_material_type_file)

            # download per age
            save_to_json(downloads_per_age, downloads_per_age_file)

            # download per Pedagogical focus
            save_to_json(downloads_per_pedagogical_focus, downloads_per_pedagogical_focus_file)

            # download per language
            save_to_json(downloads_per_language, downloads_per_language_file)

            # download per materials for teacher(CPD, SOW etc)
            save_to_json(downloads_per_material_for_teacher, downloads_per_material_for_teacher_file)

            # download per resource
            save_to_json(downloads_per_resource, downloads_per_resource_file)
            save_to_json(resource_titles, resource_titles_file)
        end
    end

    # record download_total
    def record_downloads_total(downloads_total)
        solr = RSolr.connect :url => SOLR
        response = solr.get 'select', :params => {
            :q=>'has_model_ssim:Downloader',
            :start=>0,
            :rows=>2147483647
        }
        downloads_total['total'] = response['response']['numFound'].to_i
    end

    # analysis Solr document and update download_per_day
    def record_downloads_per_day(solr_doc, downloads_per_day)
        download_time = Date.parse(solr_doc['system_create_dtsi']).strftime("%Y.%m")
        if downloads_per_day[download_time].nil?
            downloads_per_day[download_time] = 1 unless download_time.blank?
        else
            downloads_per_day[download_time] = downloads_per_day[download_time] + 1 unless download_time.blank?
        end
    end

    # analysis Solr document and update downloads_per_status
    def record_downloads_per_status(solr_doc, downloads_per_status)
        unless solr_doc['downloader_status_tesim'].nil?
            solr_doc['downloader_status_tesim'].each do |status|
                # count current status
                if downloads_per_status[status].nil?
                    downloads_per_status[status] = 1
                else
                    downloads_per_status[status] = downloads_per_status[status] + 1
                end

                # also count current status' parent if it has a parent status
                unless STATUS_PARENT_MAP[status].nil?
                    if downloads_per_status[STATUS_PARENT_MAP[status]].nil?
                        downloads_per_status[STATUS_PARENT_MAP[status]] = 1
                    else
                        downloads_per_status[STATUS_PARENT_MAP[status]] = downloads_per_status[STATUS_PARENT_MAP[status]] + 1
                    end
                end
            end
        end
    end

    # analysis Solr document and update download_per_age
    def record_downloads_per_age(resource_doc, downloads_per_age)
        unless resource_doc.blank? or resource_doc == '{}' or resource_doc['age_tesim'].blank?
            resource_doc['age_tesim'].each do |age|
                if downloads_per_age[age].nil?
                    downloads_per_age[age] = 1
                else
                    downloads_per_age[age] = downloads_per_age[age] + 1
                end
            end
        end
    end

    # analysis Solr document and update download_per_pedagogical_focus
    def record_downloads_per_pedagogical_focus(resource_doc, downloads_per_pedagogical_focus)
        unless resource_doc.blank? or resource_doc == '{}' or resource_doc['area_of_research_tesim'].blank?
            resource_doc['area_of_research_tesim'].each do |ar|
                if downloads_per_pedagogical_focus[ar].nil?
                    downloads_per_pedagogical_focus[ar] = 1
                else
                    downloads_per_pedagogical_focus[ar] = downloads_per_pedagogical_focus[ar] + 1
                end
            end
        end
    end

    # analysis Solr document and update download_per_material_for_teacher
    def record_downloads_per_material_for_teacher(resource_doc, downloads_per_material_for_teacher)
        unless resource_doc.blank? or resource_doc == '{}' or resource_doc['material_for_teachers_tesim'].blank?
            resource_doc['material_for_teachers_tesim'].each do |m|
                if downloads_per_material_for_teacher[m].nil?
                    downloads_per_material_for_teacher[m] = 1
                else
                    downloads_per_material_for_teacher[m] = downloads_per_material_for_teacher[m] + 1
                end
            end
        end
    end

    # analysis Solr document and update download_per_resource
    def record_downloads_per_resource(resource_doc, downloads_per_resource, resource_titles)
        return if resource_doc.blank? or resource_doc['id'].blank?

        resource_id = resource_doc['id']
        # Store resource title
        unless resource_doc.blank? or resource_doc == '{}' or resource_doc['title_tesim'].blank?
            resource_titles[resource_id] = resource_doc['title_tesim'][0] unless resource_doc['title_tesim'].blank?
        end

        if downloads_per_resource[resource_id].nil?
            downloads_per_resource[resource_id] = 1
        else
            downloads_per_resource[resource_id] = downloads_per_resource[resource_id] + 1
        end
    end

    # analysis Solr document and update download_per_language
    def record_downloads_per_language(resource_doc, download_per_language)
        unless resource_doc.blank? or resource_doc == '{}' or resource_doc['language_tesim'].blank?
            resource_doc['language_tesim'].each do |l|
                if download_per_language[l].blank?
                    download_per_language[l] = 1
                else
                    download_per_language[l] = download_per_language[l] + 1
                end
            end
        end
    end

    # analysis Solr document and update downloads_per_material_type
    def record_downloads_per_material_type(resource_doc, downloads_per_material_type)
        unless resource_doc.blank? or resource_doc == '{}' or resource_doc['type_of_material_tesim'].blank?
            resource_doc['type_of_material_tesim'].each do |t|
                if downloads_per_material_type[t].nil?
                    downloads_per_material_type[t] = 1
                else
                    downloads_per_material_type[t] = downloads_per_material_type[t] + 1
                end
            end
        end
    end

    # save_to_json
    def save_to_json(json_string, file_name)
        File.open(file_name, "w:UTF-8") do |f|
            f.write json_string
        end
    end

    def get_solr_doc(solr_query)
        solr = RSolr.connect :url => SOLR
        response = solr.get 'select', :params => {
            :q=>solr_query,
            :start=>0,
            :rows=>2147483647
        }
        if response['response']['numFound']==0
            JSON.parse('{}')
        else
            response['response']['docs']
        end
    end

end