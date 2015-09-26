class Section < ActiveRecord::Base
  belongs_to :term
  belongs_to :room
  belongs_to :user
  belongs_to :course
  
  has_one :meeting_day_time, dependent: :destroy
  accepts_nested_attributes_for :meeting_day_time
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  
  alias :instructor :user
  
  def name
    "#{course_instructor} / #{term.name} / #{meeting_day_time.start_str} / $#{total_fee.to_i}"
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
  
  def instructor_fee
    fee
  end

  COOP_REG_FEE = 10
  def registration_fee
    COOP_REG_FEE
  end

  def total_fee
    instructor_fee + registration_fee
  end

  def self.past
    Term.past.map {|term| term.sections }.flatten
  end
  
  def self.not_past
    Term.not_past.map {|term| term.sections }.flatten
  end

  def enrolled
    enrollments.size
  end

  def teacher; user; end

  def enrollment_limit_met?
    enrollment_limit ? (enrolled >= enrollment_limit) : false
  end
end
