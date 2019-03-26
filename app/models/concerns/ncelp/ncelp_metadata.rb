module Ncelp
    module NcelpMetadata extend ActiveSupport::Concern
        included do
            # Ncelp title, we don't use Hyrax work title as it's multiple
            property :ncelp_title, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#ncelp_title'), multiple: false do |index|
                index.as :stored_searchable, :sortable
            end

            # Affiliation/institution
            #property :affiliation, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#affiliation'), multiple: true do |index|
            #    index.as :stored_searchable, :sortable, :facetable
            #end

            # One line description
            property :one_line_description, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#one_line_description'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Full description
            property :full_description, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#full_description'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Language-other
            property :language_other, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#language_other'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Type of material
            property :type_of_material, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#type_of_material'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Thematic
            property :thematic, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#thematic'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # material_for_teachers
            property :material_for_teachers, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#material_for_teachers'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # material_for_teachers_other
            property :material_for_teachers_other, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#material_for_teachers_other'), multiple: false do |index|
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

            # Area of research other
            property :area_of_research_other, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#area_of_research_other'), multiple: false do |index|
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

            # Link to OASIS
            property :link_to_oasis, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#link_to_oasis'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Link to IRIS
            property :link_to_iris, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#link_to_iris'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # Link to video on VEO repository
            property :link_to_video, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#link_to_video'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # References to other material
            property :reference, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#reference'), multiple: true do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # email
            property :email, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#email'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end

            # notes
            property :notes, predicate: ::RDF::URI.new('http://dlib.york.ac.uk/ontologies/ncelp#notes'), multiple: false do |index|
                index.as :stored_searchable, :sortable, :facetable
            end
        end
    end
end