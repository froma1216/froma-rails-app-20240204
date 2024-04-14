require "rails_helper"

RSpec.describe "テスト" do
  let!(:player) { create(:pawapuro_player) }
  let!(:pitcher) { create(:pawapuro_pitcher, pace: 150, pawapuro_player: player) }

  describe "PawapuroPitcher モデル" do
    it "球速が取得できること" do
      expect(pitcher.pace).to eq 150
    end
  end
end
