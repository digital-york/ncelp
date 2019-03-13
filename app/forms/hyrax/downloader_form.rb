# Generated via
#  `rails generate hyrax:work Downloader`
module Hyrax
  # Generated form for Downloader
  class DownloaderForm < Hyrax::Forms::WorkForm
    self.model_class = ::Downloader
    self.terms += [:resource_type]
  end
end
