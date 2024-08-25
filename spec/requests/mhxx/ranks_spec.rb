require 'rails_helper'

RSpec.describe "Mhxx::Ranks", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/mhxx/ranks/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/mhxx/ranks/show"
      expect(response).to have_http_status(:success)
    end
  end

end
