require "rails_helper"

RSpec.describe "テスト" do
  let!(:player) { create(:pawapuro_player, player_name: "test選手名") }

  describe "PawapuroPlayer モデル" do
    it "選手名が取得できること" do
      expect(player.player_name).to eq "test選手名"
    end
  end
end
