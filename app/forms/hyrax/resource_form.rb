# Generated via
#  `rails generate hyrax:work Resource`
module Hyrax
  # Generated form for Resource
  class ResourceForm < Hyrax::Forms::WorkForm
    self.model_class = ::Resource
    self.terms = [:title,                # title from default Hyrax metadata
                  :one_line_description,
                  :creator,              # creator from default Hyrax
                  :affiliation,
                  :full_description,
                  :language,             # language from default Hyrax
                  :language_other,
                  :type_of_material,
                  :material_for_teachers,
                  :material_for_teachers_other,
                  :topic,
                  :thematic,
                  :area_of_research,
                  :area_of_research_other,
                  :modality,
                  :age,
                  :exposure,
                  :file_type,
                  :link_to_oasis,
                  :link_to_iris,
                  :link_to_video,
                  :reference,
                  :terms_and_conditions,
                  :license,               # license from default Hyrax
                  :email,
                  :notes
                 ]

    self.required_fields = [
                  :title,
                  :one_line_description,
                  :creator,
                  :full_description,
                  :language,
                  :type_of_material,
                  :topic,
                  :thematic,
                  :area_of_research,
                  :modality,
                  :age,
                  :exposure,
                  :file_type,
                  :cty,
                  :terms_and_conditions,
                  :email
                 ]
  end
end
