class MeetingDayTime < ActiveRecord::Base
  belongs_to :section
  
  enum day: ["Mon","Tue","Wed","Thu","Fri","Sat"]
  
  def start_str
    self.class.time_to_s(start_time)
  end

  def end_str
    self.class.time_to_s(end_time)
  end
  
  def to_s
    "#{day} #{ApplicationHelper.range_with_dash(start_str..end_str)}"
  end
  
  def self.time_to_s time
    time.strftime("%l:%M%p")
  end
end
