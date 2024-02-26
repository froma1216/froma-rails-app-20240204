class PokemonEmeraldFactoryParticipant < ApplicationRecord
  # scope :with_lap, lambda { |lap_number|
  #   where("lap#{lap_number}_show = ?", 1)
  # }

  def self.ransackable_attributes(_auth_object = nil)
    # 検索条件を追加
    %w[name]
  end
end
