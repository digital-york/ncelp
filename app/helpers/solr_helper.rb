require 'rsolr'

module SolrHelper
    CONN = RSolr.connect :url => Figaro.env.solr_url

    def self.query(q, fl='id', rows=10, sort='', start=0 )
        CONN.get 'select', :params => {
            :q=>q,
            :fl=>fl,
            :rows=>rows,
            :sort=>sort,
            :start=>start
        }
    end
end