require 'user_agent'

class SurveyController < ApplicationController
  protect_from_forgery

  with_themed_layout 'survey'

  def new
  end

  def submit
    from                = params['from']
    collection_id       = params['collection_id']
    resource_id         = params['resource_id']
    resource_fileset_id = params['resource_fileset_id']

    if from == 'collection'
      unless params['survey']['status'].nil?
        session['survey_status'] = params['survey']['status']
      end
      unless params['survey']['participants_country'].nil?
        session['participants_country'] = params['survey']['participants_country']
      end
      unless params['survey']['email'].nil?
        session['survey_email']  = params['survey']['email']
      end
      redirect_to '/survey/saved?from='+from+'&survey_done=yes&collection_id=' + collection_id.to_s
    else
      redirect_url = '/survey/saved?from='+from+'&survey_done=yes&resource_id=' + resource_id.to_s + '&fileset_id=' + resource_fileset_id.to_s

      unless params['survey']['status'].blank?
        params['survey']['status'].each do |status|
          redirect_url = redirect_url + '&survey_status[]=' + status
        end
      end
      unless params['survey']['participants_country'].blank?
        params['survey']['participants_country'].each do |c|
          redirect_url = redirect_url + '&participants_country=' + c
        end
      end
      unless params['survey']['email'].blank?
        redirect_url = redirect_url + '&survey_email=' + params['survey']['email']
      end

      redirect_to redirect_url
    end

  rescue StandardError => e
    message = "Sorry, error occured while saving your data at"
    message += " SurveyController.submit\n"
    message += "\t #{e.backtrace}"
    Rails.logger.fatal(message)
    redirect_to '/survey/error'
  end
end
