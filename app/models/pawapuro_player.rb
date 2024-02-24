class PawapuroPlayer < ApplicationRecord
  has_one :pawapuro_pitcher, dependent: :destroy
  has_one :pawapuro_fielder, dependent: :destroy

  # ネストされた属性の許可
  accepts_nested_attributes_for :pawapuro_pitcher, :pawapuro_fielder
end
