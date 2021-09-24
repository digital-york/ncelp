require 'uri'

module StringHelper
    # convert URLs within a string into HTML a tag,
    # BUT exclude those URLs already embedded into an a tag, e.g. those added in tinymce
    def self.add_link(s)
        updated_s = s.clone
        URI.extract(s).each do |url|
            # Unless Link already with <a> tag
            # OR
            # image tag
            unless updated_s.include? "href=\"#{url}\"" or updated_s.include? "img src=\"#{url}"
                # only deal with URLs, not generic URIs, e.g. collection: / document:
                if url.start_with? 'http' or url.start_with? 'https'
                    updated_s.gsub! url, "<a href=\"#{url}\" target=\"_blank\">Link</a>"
                end
            end
        end
        updated_s
    end
end