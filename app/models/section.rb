class Section < ActiveRecord::Base
  belongs_to :term
  belongs_to :room
  belongs_to :user
  belongs_to :course
  
  has_one :meeting_day_time, dependent: :destroy
  accepts_nested_attributes_for :meeting_day_time
  has_many :enrollments, dependent: :destroy
  
  alias :instructor :user
  
  def name
    "#{course_instructor} / #{term.name} / #{meeting_day_time.start_str}"
  end

  def course_instructor
    "#{course.name} / #{instructor ? instructor.last : "None"}"
  end

  def start_time_on date
    "#{date} #{meeting_day_time.start_time.strftime("%H:%M")}".to_time
  end

  def end_time_on date
    "#{date} #{meeting_day_time.end_time.strftime("%H:%M")}".to_time
  end

  def self.past
    Term.past.map {|term| term.sections }.flatten
  end
  
  def self.not_past
    Term.not_past.map {|term| term.sections }.flatten
  end
end
