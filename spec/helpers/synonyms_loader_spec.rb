require 'rails_helper'

RSpec.describe SynonymsLoader, type: :helper do
   describe "load synonyms" do
     it "loads synonyms from YAML" do
       expect((SynonymsLoader.load_synonyms('topic', 'Holidays').include? 'break')).to be true
       expect((SynonymsLoader.load_synonyms('topic', 'Holidays').include? 'vacation')).to be true
       expect(SynonymsLoader.load_synonyms('topic', 'INVALID')).to be_nil
     end
   end
end
