# Generated by hyrax:models
class Collection < ActiveFedora::Base
  include ::Hyrax::CollectionBehavior
  # You can replace these metadata if they're not suitable
  include Hyrax::BasicMetadata
  self.indexer = Hyrax::CollectionWithBasicMetadataIndexer

  has_many :downloaders, dependent: :destroy, class_name: 'Downloader', :autosave => true, :predicate => ::RDF::URI.new('https://ncelp.org/terms#has_many_collection')
end
