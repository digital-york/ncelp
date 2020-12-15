require 'user_agent'
require 'logger'

module Hyrax
  class DownloadsController < ApplicationController
    include Hydra::Controller::DownloadBehavior
    include Hyrax::LocalFileDownloadsControllerBehavior

    def self.default_content_path
      :original_file
    end

    # Render the 404 page if the file doesn't exist.
    # Otherwise renders the file.
    def show
      log = Logger.new "log/download_controller.log"

      case file
      when ActiveFedora::File
        ## Detect if the requests come from a bot
        user_agent = UserAgent.parse(request.user_agent)
        is_bot = user_agent.browser.downcase.include? 'bot'

        # Save downloader info
        if is_bot
          log.info 'Bot detected: ' + user_agent.browser
        else
          fileset_id = params[:id]
          response = SolrHelper.query('has_model_ssim:"Resource" AND member_ids_ssim:"'+fileset_id+'"')
          resource_id = response['response']['docs'][0]['id']
          d = Resource.find(resource_id).downloaders.new
          d.ncelp_resource_id      = resource_id
          unless session['survey_status'].blank?
            if session['survey_status'].is_a? String
              d.downloader_status      = [session['survey_status']]
            else
              d.downloader_status      = session['survey_status']
            end
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
          log.info 'saved downloader: ' + d.id
        end

        super
      when String
        # For derivatives stored on the local file system
        send_local_content
      else
        raise ActiveFedora::ObjectNotFoundError
      end
    end

    private

      # Override the Hydra::Controller::DownloadBehavior#content_options so that
      # we have an attachement rather than 'inline'
      def content_options
        super.merge(disposition: 'attachment')
      end

      # Override this method if you want to change the options sent when downloading
      # a derivative file
      def derivative_download_options
        { type: mime_type_for(file), disposition: 'inline' }
      end

      # Customize the :read ability in your Ability class, or override this method.
      # Hydra::Ability#download_permissions can't be used in this case because it assumes
      # that files are in a LDP basic container, and thus, included in the asset's uri.
      def authorize_download!
        authorize! :download, params[asset_param_key]
      rescue CanCan::AccessDenied
        unauthorized_image = Rails.root.join("app", "assets", "images", "unauthorized.png")
        if File.exist? unauthorized_image
          send_file unauthorized_image, status: :unauthorized
        else
          Deprecation.warn(self, "redirect_to default_image is deprecated and will be removed from Hyrax 3.0 (copy unauthorized.png image to directory assets/images instead)")
          redirect_to default_image
        end
      end

      def default_image
        ActionController::Base.helpers.image_path 'default.png'
      end

      # Overrides Hydra::Controller::DownloadBehavior#load_file, which is hard-coded to assume files are in BasicContainer.
      # Override this method to change which file is shown.
      # Loads the file specified by the HTTP parameter `:file`.
      # If this object does not have a file by that name, return the default file
      # as returned by {#default_file}
      # @return [ActiveFedora::File, File, NilClass] Returns the file from the repository or a path to a file on the local file system, if it exists.
      def load_file
        file_reference = params[:file]
        return default_file unless file_reference

        file_path = Hyrax::DerivativePath.derivative_path_for_reference(params[asset_param_key], file_reference)
        File.exist?(file_path) ? file_path : nil
      end

      def default_file
        default_file_reference = if asset.class.respond_to?(:default_file_path)
                                   asset.class.default_file_path
                                 else
                                   DownloadsController.default_content_path
                                 end
        association = dereference_file(default_file_reference)
        association&.reader
      end

      def mime_type_for(file)
        MIME::Types.type_for(File.extname(file)).first.content_type
      end

      def dereference_file(file_reference)
        return false if file_reference.nil?
        association = asset.association(file_reference.to_sym)
        association if association && association.is_a?(ActiveFedora::Associations::SingularAssociation)
      end
  end
end
