class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :section
  
  def user
    student.user
  end
end
