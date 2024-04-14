require "rails_helper"

RSpec.describe "テスト" do
  let!(:player) { create(:pawapuro_player) }
  let!(:fielder) { create(:pawapuro_fielder, power: 80, pawapuro_player: player) }

  describe "PawapuroFitcher モデル" do
    it "パワーが取得できること" do
      expect(fielder.power).to eq 80
    end
  end
end
