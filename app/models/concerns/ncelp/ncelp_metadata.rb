module Ncelp
    module NcelpMetadata extend ActiveSupport::Concern
        included do
            # Affiliation/institution
            property :affiliation, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#affiliation'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # One line description
            property :one_line_description, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#one_line_description'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Full description
            property :full_description, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#full_description'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end
        end
    end
end