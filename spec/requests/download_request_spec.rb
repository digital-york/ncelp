require 'rails_helper'

RSpec.describe "Downloads", type: :request do

  describe "GET /collection" do
    it "returns http success" do
      get "/download/collection"
      expect(response).to have_http_status(:success)
    end
  end

end
