module Ncelp
  module SolrDocument extend ActiveSupport::Concern
    module Solr
      class Array
        # @return [Array]
        def self.coerce(input)
          ::Array.wrap(input)
        end
      end

      class String
        # @return [String]
        def self.coerce(input)
          ::Array.wrap(input).first
        end
      end

      class Date
        # @return [Date]
        def self.coerce(input)
          field = String.coerce(input)
          return if field.blank?
          begin
            ::Date.parse(field)
          rescue ArgumentError
            Rails.logger.info "Unable to parse date: #{field.first.inspect}"
          end
        end
      end
    end

    included do
      attribute :title,                    Solr::Array,  solr_name('title')
      attribute :creator,                  Solr::Array,  solr_name('creator')
      attribute :affiliation,              Solr::Array,  solr_name('affiliation')
      attribute :one_line_description,     Solr::String, solr_name('one_line_description')
      attribute :full_description,         Solr::String, solr_name('full_description')
      attribute :language,                 Solr::Array,  solr_name('language')
      attribute :language_other,           Solr::String, solr_name('language_other')
      attribute :type_of_material,         Solr::String, solr_name('type_of_material')
      attribute :topic,                    Solr::Array,  solr_name('topic')
      attribute :thematic,                 Solr::Array,  solr_name('thematic')
      attribute :area_of_research,         Solr::Array,  solr_name('area_of_research')
      attribute :modality,                 Solr::String, solr_name('modality')
      attribute :age,                      Solr::Array,  solr_name('age')
      attribute :exposure,                 Solr::String, solr_name('exposure')
      attribute :file_type,                Solr::Array,  solr_name('file_type')
      attribute :link_to_oasis,            Solr::Array,  solr_name('link_to_oasis')
      attribute :link_to_iris,             Solr::Array,  solr_name('link_to_iris')
      attribute :link_to_video,            Solr::Array,  solr_name('link_to_video')
      attribute :reference,                Solr::Array,  solr_name('reference')
      attribute :terms_and_conditions,     Solr::String, solr_name('terms_and_conditions')
      attribute :license,                  Solr::String, solr_name('license')
      attribute :email,                    Solr::String, solr_name('email')
      attribute :notes,                    Solr::String, solr_name('notes')
    end
  end
end