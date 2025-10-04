class Enrollment < ApplicationRecord
  belongs_to :user   # murid
  belongs_to :course
end
