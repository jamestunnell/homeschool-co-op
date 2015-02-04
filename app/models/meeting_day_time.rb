class MeetingDayTime < ActiveRecord::Base
  belongs_to :section
  
  enum day: ["Mon","Tue","Wed","Thu","Fri","Sat"]
  
  def to_s
    st = start_time.strftime("%l:%M%p")
    et = end_time.strftime("%l:%M%p")
    "#{day} #{ApplicationHelper.range_with_dash(st..et)}"
  end
end
