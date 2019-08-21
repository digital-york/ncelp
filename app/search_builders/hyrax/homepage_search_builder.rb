# Added to allow for the My controller to show only things I have edit access to
class Hyrax::HomepageSearchBuilder < Hyrax::SearchBuilder
  include Hyrax::FilterByType
  self.default_processor_chain += %i[add_access_controls_to_solr_params only_search_resource]

  def only_works?
    true
  end

  def only_search_resource(solr_parameters)
    solr_parameters[:fq] << "{!field f=has_model_ssim}#{Resource}"
  end
end
