class PokemonEmeraldFactoryParticipant < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    # 検索条件を追加
    %w[name lap1_show]
  end
end
