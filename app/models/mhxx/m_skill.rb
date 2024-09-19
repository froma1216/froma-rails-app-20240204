class Mhxx::MSkill < ApplicationRecord
  has_many :time_skills, dependent: :destroy
  has_many :times, through: :time_skills
end
