class Enrollment < ActiveRecord::Base
  belongs_to :enrollable, polymorphic: true
  belongs_to :section
  
  def user_responsible
    if enrollable.is_a? User
      return enrollable
    elsif enrollable.is_a? Child
      return enrollable.parent
    end
  end
end
