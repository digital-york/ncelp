module Hyrax
  module Forms
      class CollectionForm < Hyrax::Forms::WorkForm
        self.model_class = ::Collection
        self.terms = [:title,
                      :description
                     ]

        self.required_fields = [
                      :title,
                      :description
                     ]
        def self.build_permitted_params
            super + [
                :visibility
            ]
        end
      end
  end
end
