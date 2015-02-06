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
  
  def full_name
    "#{first} #{last}"
  end
end
