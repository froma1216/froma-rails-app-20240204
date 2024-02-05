class Conference < ApplicationRecord
  has_many :days, dependent: :destroy
end
