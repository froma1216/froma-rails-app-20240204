class Conference < ApplicationRecord
  has_many :days, dependent: :destroy
  has_many :users
  has_many :participations
end
