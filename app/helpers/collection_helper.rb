module CollectionHelper

    # return all files in the contained resources of a collection
    def self.get_collection_file_number(collection_id)
        number_of_files = 0

        solr_query = "has_model_ssim:Resource and member_of_collection_ids_ssim:#{collection_id}"
        resource_docs = SolrHelper.query_result_docs(solr_query)
        resource_docs.each do |resource_doc|
            number_of_files += resource_doc['file_set_ids_ssim'].length unless resource_doc['file_set_ids_ssim'].blank?
        end

        number_of_files
    end

end
