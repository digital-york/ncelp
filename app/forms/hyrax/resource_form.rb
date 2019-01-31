# Generated via
#  `rails generate hyrax:work Resource`
module Hyrax
  # Generated form for Resource
  class ResourceForm < Hyrax::Forms::WorkForm
    self.model_class = ::Resource
    self.terms += [:resource_type]
  end
end
