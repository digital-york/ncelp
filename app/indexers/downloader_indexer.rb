# Generated via
#  `rails generate hyrax:work Downloader`
class DownloaderIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata

  # save parent type
  def generate_solr_document
   super.tap do |solr_doc|
     solr_doc['parent_type_ssim'] = object.parent_type
   end
  end

end
