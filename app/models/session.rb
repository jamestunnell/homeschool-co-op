class Session < ActiveRecord::Base
  enum term: [ "Fall", "Winter", "Spring", "Summer" ]
  enum kind: [ "Quarter", "Workshop" ]
  
  has_many :sections
  
  def year_range
    start_date.year..end_date.year
  end
  
  def name
    [term, kind, ApplicationHelper.range_with_dash(year_range)].join(" ")
  end
end
