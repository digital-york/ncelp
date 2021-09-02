module FileSetHelper

    # return parent resource docs
    def self.get_parent_resource_docs(fileset_id)
        solr_query = "has_model_ssim:Resource and file_set_ids_ssim:#{fileset_id}"
        SolrHelper.query_result_docs(solr_query)
    end

end
