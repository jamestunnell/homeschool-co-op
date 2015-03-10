class User < ActiveRecord::Base
  MIN_NAME_LENGTH = 2
  MAX_NAME_LENGTH = 36
  
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

  def active_responsibilities
    responsibilities.active
  end

  def upcoming_sections
    sections.select {|s| s.term.upcoming? }
  end

  def active_sections
    sections.select {|s| s.term.active? }
  end

  def past_sections
    sections.select {|s| s.term.past? }
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
