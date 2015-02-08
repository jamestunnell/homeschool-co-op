class Section < ActiveRecord::Base
  belongs_to :term
  belongs_to :room
  belongs_to :user
  belongs_to :course
  
  has_one :meeting_day_time, dependent: :destroy
  accepts_nested_attributes_for :meeting_day_time
  has_many :enrollments
  
  alias :instructor :user
  
  def short
    "#{course.name} / #{instructor ? instructor.last : "None"} / #{term.short} / #{meeting_day_time.start_str}"
  end
  
  def long
    "#{course.name} with #{instructor ? instructor.full_name : "None"}, #{term.long} at #{meeting_day_time}"
  end
  
  alias :name :short

  def self.past
    Term.past.map {|term| term.sections }.flatten
  end
  
  def self.not_past
    Term.not_past.map {|term| term.sections }.flatten
  end
end
