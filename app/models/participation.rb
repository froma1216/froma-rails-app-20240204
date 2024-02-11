class Participation < ApplicationRecord
  belongs_to :conference
  belongs_to :user
  belongs_to :slot

  validates :user_id, presence: true
  validates :slot_id, presence: true
end
