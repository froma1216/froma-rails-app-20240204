require 'rails_helper'

RSpec.describe "Mhxx::Quests", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/mhxx/quests/show"
      expect(response).to have_http_status(:success)
    end
  end

end
