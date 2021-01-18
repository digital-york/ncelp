require 'figaro'

class DownloadController < ApplicationController

  # Access URL: /download/collection?id=COLLECTION_ID
  def collection
    log = Logger.new "log/download_controller.log"

    collection_id = params[:id]
    zipname = "#{Figaro.env.zipfile_path}#{collection_id}.zip"

    if File.file? zipname
      unless session['survey_status'].blank?
        d = Collection.find(collection_id).downloaders.new
        d.collection_id      = collection_id
        d.parent_type        = 'collection'

        if session['survey_status'].is_a? String
          d.downloader_status      = [session['survey_status']]
        else
          d.downloader_status      = session['survey_status']
        end

        unless session['participants_country'].blank?
          if session['participants_country'].is_a? String
            d.participants_country   = [session['participants_country']]
          else
            d.participants_country   = session['participants_country']
          end
        end
        unless session['survey_email'].blank?
          d.downloader_email       = session['survey_email']
        end
        d.save!
        log.info "saved downloader: #{d.id} for collection: #{collection_id}"
      end

      send_file(
          zipname,
          filename: "#{params[:id]}.zip",
          type: "application/zip"
      )
    end
  end

end
