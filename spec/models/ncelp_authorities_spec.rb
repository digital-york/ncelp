require 'rails_helper'

RSpec.describe NcelpAuthorities, type: :helper do
    describe "check authorities" do
        it "loads authority list" do
            expect((NcelpAuthorities.authority_list.include? 'age')).to be true
            expect((NcelpAuthorities.authority_list.include? 'area_of_research')).to be true
            expect((NcelpAuthorities.authority_list.include? 'exposure')).to be true
            expect((NcelpAuthorities.authority_list.include? 'file_type')).to be true
            expect((NcelpAuthorities.authority_list.include? 'language')).to be true
            expect((NcelpAuthorities.authority_list.include? 'material_for_teachers')).to be true
            expect((NcelpAuthorities.authority_list.include? 'modality')).to be true
            expect((NcelpAuthorities.authority_list.include? 'thematic')).to be true
            expect((NcelpAuthorities.authority_list.include? 'topic')).to be true
            expect((NcelpAuthorities.authority_list.include? 'type_of_material')).to be true
        end
    end
end
