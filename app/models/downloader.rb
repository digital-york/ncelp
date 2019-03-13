# Generated via
#  `rails generate hyrax:work Downloader`
class Downloader < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  belongs_to :ncelp_resource, class_name: 'Resource', :autosave => true, :predicate => ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf

  self.indexer = DownloaderIndexer

  include ::Ncelp::DownloaderMetadata

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
