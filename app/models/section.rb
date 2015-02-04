class Section < ActiveRecord::Base
  belongs_to :session
  belongs_to :room
  belongs_to :adult
  belongs_to :course
  
  has_one :meeting_day_time
  accepts_nested_attributes_for :meeting_day_time
end
