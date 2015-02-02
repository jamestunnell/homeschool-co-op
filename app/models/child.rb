class Child < ActiveRecord::Base
  belongs_to :adult

  def full_name
    "#{first} #{last}"
  end
  
  def years_old
    ((Time.now.to_date - birth_date)/365).to_i
  end
end
