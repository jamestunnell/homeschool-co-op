class Course < ActiveRecord::Base
  belongs_to :subject
  validates_presence_of :name
  
  def type
    workshop ? "Workshop" : "Class"
  end
end
