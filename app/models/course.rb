class Course < ActiveRecord::Base
  belongs_to :subject
  validates_presence_of :title
  
  def type
    workshop ? "Workshop" : "Class"
  end
end
