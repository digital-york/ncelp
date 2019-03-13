# Generated via
#  `rails generate hyrax:work Resource`
class Resource < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  has_many :downloaders, dependent: :destroy, class_name: 'Downloader', :autosave => true, :predicate => ::RDF::URI.new('https://ncelp.org/terms#has_many_resource')

  self.indexer = ResourceIndexer

  include ::Ncelp::NcelpMetadata

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
