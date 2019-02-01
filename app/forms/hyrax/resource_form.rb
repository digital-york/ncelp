# Generated via
#  `rails generate hyrax:work Resource`
module Hyrax
  # Generated form for Resource
  class ResourceForm < Hyrax::Forms::WorkForm
    self.model_class = ::Resource
    self.terms = [:title,
                  :creator,
                  :affiliation,
                  :one_line_description,
                  :full_description
                 ]

    self.required_fields = [
                  :title,
                  :creator,
                  :one_line_description,
                  :full_description
                 ]
  end
end
