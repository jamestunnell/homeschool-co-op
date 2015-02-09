class TermEndValidator < ActiveModel::Validator
  def validate(term)
    if term.errors[:end_date].empty? && term.errors[:start_date].empty?
      unless term.end_date >= term.start_date
        term.errors[:end_date] << 'End date must be >= start date.'
      end
    end
  end
end

class Term < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  has_many :enrollments, through: :sections
  
  validates_presence_of :start_date
  validates_presence_of :end_date
  
  include ActiveModel::Validations
  validates_with TermEndValidator
  
  def year_range
    start_date.year..end_date.year
  end
  
  def type
    workshop ? "Workshop" : "Quarter"
  end
  
  def start_season_year
    y = start_date.year
    season_dates = {
      "#{"%04d" % (y-1)}-12-21".to_date => "Winter #{y}",
      "#{"%04d" % y}-03-21".to_date => "Spring #{y}",
      "#{"%04d" % y}-06-21".to_date => "Summer #{y}",
      "#{"%04d" % y}-09-21".to_date => "Fall #{y}",
      "#{"%04d" % y}-12-21".to_date => "Winter #{"%04d" % (y+1)}"
    }
    season_dates.min_by {|date,label| (start_date - date).abs }[1]
  end
  
  def name
    "#{start_season_year} #{type}"
  end
  
  def days_long
    (end_date - start_date).to_i
  end
  
  def weeks_long
    (days_long/7.0).round
  end
  
  scope :upcoming, -> { where("start_date > ?", Date.today) }
  scope :past, -> { where("end_date < ?", Date.today) }
  scope :not_past, -> { where("end_date >= ?", Date.today) }
  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.today, Date.today) }
end
