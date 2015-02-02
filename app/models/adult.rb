class Adult < ActiveRecord::Base
  has_many :children
  
  def full_name
    "#{first} #{last}"
  end
end
