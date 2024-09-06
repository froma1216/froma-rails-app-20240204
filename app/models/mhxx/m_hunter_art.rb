class Mhxx::MHunterArt < ApplicationRecord
  belongs_to :m_weapon_type

  has_many :time
end
