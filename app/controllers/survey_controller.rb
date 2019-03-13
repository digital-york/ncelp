class SurveyController < ApplicationController
  protect_from_forgery

  with_themed_layout 'survey'

  def new; end

  def submit
    resource_id         = params['resource_id']
    resource_fileset_id = params['resource_fileset_id']

    d = Resource.find(resource_id).downloaders.new
    d.downloader_status      = params['survey']['status'] unless params['survey']['status'].nil?
    d.participants_country   = params['survey']['participants_country'] unless params['survey']['participants_country'].nil?
    d.downloader_email       = params['survey']['email'] unless params['survey']['email'].nil?
    d.save!

    redirect_to '/survey/saved?survey_done=yes&resource_id=' + resource_id.to_s + '&downloader_id=' + d.id.to_s + '&fileset_id=' + resource_fileset_id.to_s
  rescue StandardError => e
    puts e
    redirect_to '/survey/error'
  end
end
