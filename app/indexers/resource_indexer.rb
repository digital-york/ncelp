# Generated via
#  `rails generate hyrax:work Resource`
class ResourceIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata

  # add custom indexing behavior for authority fields:
  def generate_solr_document
    super.tap do |solr_doc|
      # add authority labels into solr
      NcelpAuthorities.authority_list.each do |field_name|
        authority_filename = "#{field_name}.yml"
        begin
          unless object[field_name].nil?
            # If current field value is a String
            if object[field_name].is_a? String
              solr_doc[field_name+'_label_tesim'] = GenericLocalAuthorityService.id_to_label(field_name, object[field_name])

              # save synonyms
              synonyms = SynonymsLoader.load_synonyms(field_name, object[field_name])
              solr_doc[field_name+'_synonyms_tesim'] = synonyms unless synonyms.nil?
            else # if current field value is a collection
              labels = []
              synonyms = []
              object[field_name].each do |field_value|
                unless (field_value.nil? or field_value=='')
                  labels << GenericLocalAuthorityService.id_to_label(field_name, field_value)
                  s = SynonymsLoader.load_synonyms(field_name, field_value)
                  synonyms << s unless s.nil?
                end
              end
              solr_doc[field_name+'_label_tesim'] = labels
              solr_doc[field_name+'_synonyms_tesim'] = synonyms
            end
          end
        rescue => exception
          Rails.logger.error('Failed while indexing label for ' + field_name)
          puts exception.backtrace
        end
      end
    end
  end
end
