class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :section
  
  def user
    student.user
  end

  def term_past?
    section.term.past?
  end

  def teacher
    section.user
  end

  def course_name
    section.course.name
  end

  def section_fees
    section.total_fee
  end

  def self.upcoming
    all.select {|e| e.section.term.upcoming? }
  end

  def self.active
    all.select {|e| e.section.term.active? }
  end
  
  def self.past
    all.select {|e| e.section.term.past? }
  end

  def self.not_past
    all.select {|e| e.section.term.not_past? }
  end
end
