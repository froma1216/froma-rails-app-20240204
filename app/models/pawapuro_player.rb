class PawapuroPlayer < ApplicationRecord
  belongs_to :pawapuro_pitcher
  belongs_to :pawapuro_fielder

  # ネストされた属性の許可
  accepts_nested_attributes_for :pawapuro_pitcher, :pawapuro_fielder
end
