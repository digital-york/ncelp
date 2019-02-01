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

            # Type of material
            property :type_of_material, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#type_of_material'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Topic
            property :topic, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#topic'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Area of research
            property :area_of_research, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#area_of_research'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Modality
            property :modality, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#modality'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Age
            property :age, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#age'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Exposure
            property :exposure, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#exposure'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # File type
            property :file_type, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#file_type'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end
        end
    end
end