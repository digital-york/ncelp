require 'uri'

module StringHelper
    # convert URLs within a string into HTML a tag,
    # BUT exclude those URLs already embedded into an a tag, e.g. those added in tinymce
    def self.add_link(s)
        updated_s = s.clone
        URI.extract(s).each do |url|
            unless s.include? "href=\"#{url}\""
                updated_s.gsub! url, "<a href=\"#{url}\">Link</a>"
            end
        end
        updated_s
    end
end