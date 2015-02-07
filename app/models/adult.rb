class Adult < ActiveRecord::Base
  has_many :students, dependent: :destroy
  has_many :enrollments, as: :enrollable, dependent: :destroy
  def full_name
    "#{first} #{last}"
  end
  
  def all_enrollments
    enrollments + students.map {|c| c.enrollments }.flatten
  end
end
