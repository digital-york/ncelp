# Generated via
#  `rails generate hyrax:work Downloader`
class Downloader < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  belongs_to :ncelp_resource, class_name: 'Resource', :autosave => true, :predicate => ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
  belongs_to :collection, class_name: 'Collection', :autosave => true, :predicate => ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf

  # store parent type, e.g. collection or resource for future reporting
  property :parent_type, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#downloader_parent_type'), multiple: false do |index|
    index.as :stored_searchable, :sortable
  end

  self.indexer = DownloaderIndexer

  include ::Ncelp::DownloaderMetadata

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
