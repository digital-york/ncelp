module Ncelp
    module NcelpMetadata extend ActiveSupport::Concern
        included do
            # Affiliation/institution
            property :affiliation, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#affiliation'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end
        end
    end
end