# Generated via
#  `rails generate hyrax:work Resource`
module Hyrax
  # Generated form for Resource
  class ResourceForm < Hyrax::Forms::WorkForm
    self.model_class = ::Resource
    self.terms = [:title,                # title from default Hyrax metadata
                  :creator,              # creator from default Hyrax
                  :affiliation,
                  :one_line_description,
                  :full_description,
                  :language,             # language from default Hyrax
                  :type_of_material,
                  :topic,
                  :area_of_research,
                  :modality,
                  :age,
                  :exposure,
                  :file_type
                 ]

    self.required_fields = [
                  :title,
                  :creator,
                  :one_line_description,
                  :full_description,
                  :language,
                  :type_of_material,
                  :topic,
                  :area_of_research,
                  :modality,
                  :age,
                  :exposure,
                  :file_type
                 ]
  end
end
