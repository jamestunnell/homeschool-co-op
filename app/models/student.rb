class Student < ActiveRecord::Base
  belongs_to :user
  validates :first, presence: true
  validates_length_of :first, :minimum => User::MIN_NAME_LENGTH, :maximum => User::MAX_NAME_LENGTH
  has_many :enrollments, dependent: :destroy
  
  alias :parent :user
  
  def full_name
    if last && !last.empty?
      last_str = last
    else
      last_str = parent.last
    end
    "#{first} #{last_str}"
  end
  
  def years_old
    ((Time.now.to_date - birth_date)/365).to_i
  end
end
