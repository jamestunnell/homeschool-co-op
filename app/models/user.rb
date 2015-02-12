class User < ActiveRecord::Base
  MIN_NAME_LENGTH = 2
  MAX_NAME_LENGTH = 36
  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable
         
  validates_presence_of :first
  validates_presence_of :last
  validates_length_of :first, :minimum => MIN_NAME_LENGTH, :maximum => MAX_NAME_LENGTH
  validates_length_of :last, :minimum => MIN_NAME_LENGTH, :maximum => MAX_NAME_LENGTH
  
  has_many :students, dependent: :destroy
  has_many :enrollments, through: :students
  has_many :responsibilities, dependent: :destroy
  
  def full_name
    "#{first} #{last}"
  end
  
  def active_responsibilities
    responsibilities.active
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
    active_responsibilities.any? {|r| r.cataloging? }
  end  
end
