class Session < ActiveRecord::Base
  enum term: [ "Fall", "Winter", "Spring", "Summer" ]
  enum kind: [ "Quarter", "Workshop" ]
  
  def year_range
    start_date.year..end_date.year
  end  
end
