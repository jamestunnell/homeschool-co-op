class User < ActiveRecord::Base
  MIN_NAME_LENGTH = 2
  MAX_NAME_LENGTH = 36
  
  MAX_BIO_LENGTH = 1000

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  phony_normalize :phone, :default_country_code => 'US'
  phony_normalize :emergency_phone, :default_country_code => 'US'

  validates_presence_of :first
  validates_presence_of :last
  validates_length_of :first, :minimum => MIN_NAME_LENGTH, :maximum => MAX_NAME_LENGTH
  validates_length_of :last, :minimum => MIN_NAME_LENGTH, :maximum => MAX_NAME_LENGTH

  validates_length_of :bio, :maximum => MAX_BIO_LENGTH

  validates :phone, phony_plausible: true
  validates :emergency_phone, phony_plausible: true

  has_many :students, dependent: :destroy
  has_many :sections
  has_many :enrollments, through: :students
  has_many :responsibilities, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def full_name
    "#{first} #{last}"
  end

  # can contact the given user if a) is admin, b) is teacher 
  # of the user's child, or c) is parent of user's student
  def can_contact? user
    if is_admin?
      return true
    else
      students = not_past_sections.map {|s| s.students }.flatten.uniq
      if (students & user.students).any?
        return true
      else
        teachers = not_past_enrollments.map {|e| e.teacher }
        return teachers.include? user
      end
    end
  end

  def unpaid_enrollments
    enrollments.select {|e| !e.paid }
  end

  def active_responsibilities
    responsibilities.active
  end

  def upcoming_sections
    sections.select {|s| s.term.upcoming? }
  end

  def upcoming_enrollments
    enrollments.select {|e| e.section.term.upcoming? }
  end

  def active_enrollments
    enrollments.select {|e| e.section.term.active? }
  end

  def past_enrollments
    enrollments.select {|e| e.section.term.past? }
  end

  def not_past_enrollments
    enrollments.select {|e| e.section.term.not_past? }
  end

  def active_sections
    sections.select {|s| s.term.active? }
  end

  def past_sections
    sections.select {|s| s.term.past? }
  end

  def not_past_sections
    sections.select {|s| s.term.not_past? }
  end

  def is_admin?
    can_coordinate? || can_register? || can_schedule?
  end

  def can_coordinate?
    active_responsibilities.any? {|r| r.coordination? }
  end
  
  def can_register?
    active_responsibilities.any? {|r| r.registration? }
  end
  
  def can_schedule?
    active_responsibilities.any? {|r| r.scheduling? }
  end
  
  def can_catalog?
    active_responsibilities.any? {|r| r.cataloging? } || can_schedule?
  end
end
