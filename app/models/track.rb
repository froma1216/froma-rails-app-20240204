class Track < ApplicationRecord
  has_many :slots, dependent: :destroy
  belongs_to :day
end
