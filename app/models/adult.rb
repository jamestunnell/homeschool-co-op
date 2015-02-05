class Adult < ActiveRecord::Base
  has_many :children
  has_many :enrollments, as: :enrollable
  def full_name
    "#{first} #{last}"
  end
  
  def all_enrollments
    enrollments + children.map {|c| c.enrollments }.flatten
  end
end
