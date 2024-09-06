class Mhxx::MWeapon < ApplicationRecord
  belongs_to :m_weapon_type

  has_many :time

  extend Enumerize
  enumerize :element, in: Enums.element
end
