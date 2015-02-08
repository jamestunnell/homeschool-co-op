class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable
         
  validates_presence_of :first
  validates_presence_of :last
  validates_length_of :first, :minimum => 2, :maximum => 36
  validates_length_of :last, :minimum => 2, :maximum => 36
  
  has_many :students, dependent: :destroy
  has_many :enrollments, through: :students
  has_many :responsibilities, dependent: :destroy
  
  def full_name
    "#{first} #{last}"
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
  
  def active_responsibilities
    responsibilities.select {|r| r.active? }
  end
end
