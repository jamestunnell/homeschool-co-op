class Child < ActiveRecord::Base
  belongs_to :user
  validates :first, presence: true
  has_many :enrollments, as: :enrollable, dependent: :destroy
  
  alias :parent :user
  
  def full_name
    "#{first} #{last}"
  end
  
  def years_old
    ((Time.now.to_date - birth_date)/365).to_i
  end
end
