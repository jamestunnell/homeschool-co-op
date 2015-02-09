class Section < ActiveRecord::Base
  belongs_to :term
  belongs_to :room
  belongs_to :user
  belongs_to :course
  
  has_one :meeting_day_time, dependent: :destroy
  accepts_nested_attributes_for :meeting_day_time
  has_many :enrollments, dependent: :destroy
  
  alias :instructor :user
  
  def short_name
    "#{course.name} / #{instructor ? instructor.last : "None"} / #{term.short_name} / #{meeting_day_time.start_str}"
  end
  
  def long_name
    "#{course.name} with #{instructor ? instructor.full_name : "None"}, #{term.name} at #{meeting_day_time}"
  end
  
  alias :name :short_name

  def self.past
    Term.past.map {|term| term.sections }.flatten
  end
  
  def self.not_past
    Term.not_past.map {|term| term.sections }.flatten
  end
end
