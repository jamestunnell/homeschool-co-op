class Adult < ActiveRecord::Base
  has_many :children, dependent: :destroy
  has_many :enrollments, as: :enrollable, dependent: :destroy
  def full_name
    "#{first} #{last}"
  end
  
  def all_enrollments
    enrollments + children.map {|c| c.enrollments }.flatten
  end
end
