class Mhxx::MWeaponType < ApplicationRecord
  has_many :m_weapon
  has_many :m_hunter_art

  extend Enumerize
  enumerize :weapon_type_division, in: Enums.weapon_type_division
end
