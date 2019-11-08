class SurveyController < ApplicationController
  protect_from_forgery

  with_themed_layout 'survey'

  def new; end

  def submit
    from                = params['from']
    collection_id       = params['collection_id']
    resource_id         = params['resource_id']
    resource_fileset_id = params['resource_fileset_id']

    if from == 'collection'
      d = Collection.find(collection_id).downloaders.new
      d.downloader_status      = params['survey']['status'] unless params['survey']['status'].nil?
      d.participants_country   = params['survey']['participants_country'] unless params['survey']['participants_country'].nil?
      d.downloader_email       = params['survey']['email'] unless params['survey']['email'].nil?
      d.collection_id          = collection_id
      d.save!

      redirect_to '/survey/saved?from='+from+'&survey_done=yes&collection_id=' + collection_id.to_s + '&downloader_id=' + d.id.to_s
    else
      d = Resource.find(resource_id).downloaders.new
      d.downloader_status      = params['survey']['status'] unless params['survey']['status'].nil?
      d.participants_country   = params['survey']['participants_country'] unless params['survey']['participants_country'].nil?
      d.downloader_email       = params['survey']['email'] unless params['survey']['email'].nil?
      d.ncelp_resource_id      = resource_id
      d.save!

      redirect_to '/survey/saved?from='+from+'&survey_done=yes&resource_id=' + resource_id.to_s + '&downloader_id=' + d.id.to_s + '&fileset_id=' + resource_fileset_id.to_s
    end

  rescue StandardError => e
    message = "Sorry, error occured while saving your data at"
    message += " SurveyController.submit\n"
    message += "\t #{e.backtrace}"
    Rails.logger.fatal(message)
    redirect_to '/survey/error'
  end
end
