class Term < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  has_many :enrollments, through: :sections
  
  validates_presence_of :start_date
  validates_presence_of :end_date
  validate :end_date_not_before_start_date

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

  def active_days
    sections.map {|section| section.meeting_day_time.day }.uniq
  end

  def time_range_activity day
    sd = start_date
    secs = sections.select {|section| section.meeting_day_time.day == day }
    time_points = []
    secs.each do |s|
      time_points.push(s.start_time_on(sd))
      time_points.push(s.end_time_on(sd))
    end
    time_points = time_points.uniq.sort
    time_range_activity = {}
    (1...time_points.size).each do |i|
      l = time_points[i-1]
      r = time_points[i]
      active_secs = secs.select do |s|
        sl = s.start_time_on(sd)
        sr = s.end_time_on(sd)
        (sl >= l && sl < r) || (sr > l && sr <= r)
      end
      if active_secs.any?
        time_range_activity[l..r] = active_secs
      end
    end
    return time_range_activity
  end
  
  scope :upcoming, -> { where("start_date > ?", Date.today) }
  scope :past, -> { where("end_date < ?", Date.today) }
  scope :not_past, -> { where("end_date >= ?", Date.today) }
  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.today, Date.today) }

  def past?
    end_date < Date.today
  end

  def not_past?
    end_date >= Date.today
  end

  def active?
    d = Date.today
    start_date <= d && end_date >= d
  end

  def upcoming?
    start_date > Date.today
  end

  def end_date_not_before_start_date
    end_date >= start_date
  end
end
