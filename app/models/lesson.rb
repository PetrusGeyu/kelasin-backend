class Lesson < ApplicationRecord
  belongs_to :course
  has_many :assessments
  has_many :progresses
end
