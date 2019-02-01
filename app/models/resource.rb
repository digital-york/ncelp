# Generated via
#  `rails generate hyrax:work Resource`
class Resource < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = ResourceIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title,   presence: { message: 'Your resource must have a title.' }
  validates :creator, presence: { message: 'Your resource must have a creator.' }

  include ::Ncelp::NcelpMetadata

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
