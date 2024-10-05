require "rails_helper"

RSpec.describe "Mhxx::BookmarkQuests", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/mhxx/bookmark_quests/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/mhxx/bookmark_quests/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
