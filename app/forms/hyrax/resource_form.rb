# Generated via
#  `rails generate hyrax:work Resource`
module Hyrax
  # Generated form for Resource
  class ResourceForm < Hyrax::Forms::WorkForm
    self.model_class = ::Resource
    self.terms = [:ncelp_title,          # don't use title from default Hyrax metadata as NCELP title is NOT multiple filed
                  :one_line_description,
                  :creator,              # creator from default Hyrax
                  # :affiliation,
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
                  :license,               # license from default Hyrax
                  :email,
                  :notes
                 ]

    self.required_fields = [
                  :ncelp_title,
                  :one_line_description,
                  :creator,
                  :full_description,
                  :language,
                  :type_of_material,
                  :area_of_research,
                  :file_type,
                  :cty,
                  :email
                 ]
  end
end
