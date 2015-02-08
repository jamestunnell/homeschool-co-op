class Term < ActiveRecord::Base
  enum season: [ "Fall", "Winter", "Spring", "Summer" ]
  has_many :sections, dependent: :destroy
  has_many :enrollments, through: :sections
  
  def year_range
    start_date.year..end_date.year
  end
  
  def type
    workshop ? "Workshop" : "Quarter"
  end
  
  def short
    "#{season} #{type}"
  end
  
  def long
    "#{short} #{ApplicationHelper.range_with_dash(year_range)}"
  end
  
  alias :name :long
  
  scope :upcoming, -> { where("start_date > ?", Date.today) }
  scope :past, -> { where("end_date < ?", Date.today) }
  scope :not_past, -> { where("end_date >= ?", Date.today) }
  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.today, Date.today) }
end
