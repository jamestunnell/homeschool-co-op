class Child < ActiveRecord::Base
  def years_old
    ((Time.now.to_date - birth_date)/365).to_i
  end
end
