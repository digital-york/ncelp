require 'yaml'

class SynonymsLoader
    @@synonym_path = 'config/authorities/'

    def self.load_synonyms(authority_name, term_id)
        begin
            synonyms = YAML.load_file("#{@@synonym_path}#{authority_name}_synonyms.yml")
            synonyms['terms'].select{|element| element['id'] == term_id }[0]['synonyms'].values
        rescue
            nil
        end
    end
end