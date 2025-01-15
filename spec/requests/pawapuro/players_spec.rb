require 'rails_helper'

RSpec.describe "Pawapuro::Players", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/pawapuro/players/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /details" do
    it "returns http success" do
      get "/pawapuro/players/details"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/pawapuro/players/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/pawapuro/players/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/pawapuro/players/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/pawapuro/players/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/pawapuro/players/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
