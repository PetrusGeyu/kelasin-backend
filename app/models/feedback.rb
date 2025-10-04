class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :content, presence: true
end
