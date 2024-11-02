class Pawapuro::Player < ApplicationRecord
  belongs_to :main_position
  belongs_to :user
end
