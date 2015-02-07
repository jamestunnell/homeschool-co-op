class Section < ActiveRecord::Base
  belongs_to :term
  belongs_to :room
  belongs_to :user
  belongs_to :course
  
  has_one :meeting_day_time, dependent: :destroy
  accepts_nested_attributes_for :meeting_day_time
  
  alias :instructor :user
  
  def course_and_term
    "#{course.title}, #{term.name}"
  end
end
