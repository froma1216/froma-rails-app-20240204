class PawapuroPlayer < ApplicationRecord
  has_one :pawapuro_pitcher, dependent: :destroy
  has_one :pawapuro_fielder, dependent: :destroy

  validates :last_name, presence: true, length: { maximum: 10 }
  validates :first_name, presence: true, length: { maximum: 10 }
  validates :player_name, presence: true, length: { maximum: 10 }
  validates :main_position, presence: true

  # ネストされた属性の許可
  accepts_nested_attributes_for :pawapuro_pitcher, :pawapuro_fielder
end
