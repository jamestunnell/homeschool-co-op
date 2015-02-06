class Term < ActiveRecord::Base
  enum term: [ "Fall", "Winter", "Spring", "Summer" ]
  has_many :sections, dependent: :destroy
  
  def year_range
    start_date.year..end_date.year
  end
  
  def type
    workshop ? "Workshop" : "Quarter"
  end
  
  def name
    [term, type, ApplicationHelper.range_with_dash(year_range)].join(" ")
  end
end
