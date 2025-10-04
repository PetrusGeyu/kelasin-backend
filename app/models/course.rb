class Course < ApplicationRecord
  belongs_to :user     # guru (owner)
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  # ✅ Tambahkan ini:
  has_many :feedbacks, dependent: :destroy

  # helper
  def students_count
    enrollments.size
  end
end
