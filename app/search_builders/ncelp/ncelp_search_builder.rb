module Ncelp
  class NcelpSearchBuilder < Hyrax::CatalogSearchBuilder
    self.default_processor_chain += %i[add_authority_label_field_to_query add_ncelp_text_fields_to_query add_other_fields_to_query only_search_resource_or_collection]

    # Add NCELP authority label and synonyms fields to Solr query parameters
    def add_authority_label_field_to_query(solr_parameters)
      NcelpAuthorities.authority_list.each do |field_name|
        solr_parameters[:qf] += format(' %s_label_tesim', field_name)
        # Also query synonyms fields
        solr_parameters[:qf] += format(' %s_synonyms_tesim', field_name)
      end
    end

    # Add NCELP text fields to Solr query parameters
    def add_ncelp_text_fields_to_query(solr_parameters)
      solr_parameters[:qf] += ' ncelp_title_tesim'
      solr_parameters[:qf] += ' creator_tesim'
      solr_parameters[:qf] += ' one_line_description_tesim'
      solr_parameters[:qf] += ' full_description_tesim'
      solr_parameters[:qf] += ' affiliation_tesim'
      solr_parameters[:qf] += ' notes_tesim'
    end

    # Add 'other' fields to Solr query parameters
    def add_other_fields_to_query(solr_parameters)
      solr_parameters[:qf] += ' language_other_tesim'
      solr_parameters[:qf] += ' material_for_teachers_other_tesim'
      solr_parameters[:qf] += ' area_of_research_other_tesim'
    end

    # Only query Resource / Collection
    def only_search_resource_or_collection(solr_parameters)
      if solr_parameters[:fq].include? '{!term f=human_readable_type_sim}Collection'
        solr_parameters[:fq] << "{!field f=has_model_ssim}#{Collection}"
      else
        solr_parameters[:fq] << "{!field f=has_model_ssim}#{Resource}"
      end
    end
  end
end
