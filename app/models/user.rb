class User < ApplicationRecord
  has_secure_password

  has_one :profile, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :progresses
  has_many :feedbacks

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[guru murid] }

  # Tambahkan ini 👇
  def name
    [first_name, last_name].compact.join(" ").strip
  end
end
