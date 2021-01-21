module ResourceHelper

    # return languages
    # Usage: d = FileSetHelper.get_parent_resource_docs('td96k248x')
    #        ResourceHelper.get_languages(d)
    def self.get_languages(resource_docs)
        languages = []
        resource_docs.each do |resource_doc|
            unless resource_doc['language_tesim'].blank?
                resource_doc['language_tesim'].each do |l|
                    languages << l unless languages.include? l
                end
            end
        end
        languages
    end

    # return type of materials
    # Usage: d = FileSetHelper.get_parent_resource_docs('td96k248x')
    #        ResourceHelper.get_type_of_materials(d)
    def self.get_type_of_materials(resource_docs)
        type_of_materials = []
        resource_docs.each do |resource_doc|
            unless resource_doc['type_of_material_label_tesim'].blank?
                resource_doc['type_of_material_label_tesim'].each do |t|
                    type_of_materials << t unless type_of_materials.include? t
                end
            end
        end
        type_of_materials
    end

    # return ages
    # Usage: d = FileSetHelper.get_parent_resource_docs('td96k248x')
    #        ResourceHelper.get_ages(d)
    def self.get_ages(resource_docs)
        ages = []
        resource_docs.each do |resource_doc|
            unless resource_doc['age_label_tesim'].blank?
                resource_doc['age_label_tesim'].each do |a|
                    ages << a unless ages.include? a
                end
            end
        end
        ages
    end

    # return pedagogical_focus
    # Usage: d = FileSetHelper.get_parent_resource_docs('td96k248x')
    #        ResourceHelper.get_pedagogical_focus(d)
    def self.get_pedagogical_focus(resource_docs)
        pedagogical_focus = []
        resource_docs.each do |resource_doc|
            unless resource_doc['area_of_research_tesim'].blank?
                resource_doc['area_of_research_tesim'].each do |a|
                    pedagogical_focus << a unless pedagogical_focus.include? a
                end
            end
        end
        pedagogical_focus
    end

    # return material_for_teacher
    # Usage: d = FileSetHelper.get_parent_resource_docs('td96k248x')
    #        ResourceHelper.get_material_for_teacher(d)
    def self.get_material_for_teacher(resource_docs)
        material_for_teacher = []
        resource_docs.each do |resource_doc|
            unless resource_doc['material_for_teachers_label_tesim'].blank?
                resource_doc['material_for_teachers_label_tesim'].each do |m|
                    material_for_teacher << m unless material_for_teacher.include? m
                end
            end
        end
        material_for_teacher
    end

end
