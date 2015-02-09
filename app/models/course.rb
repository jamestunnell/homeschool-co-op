class Course < ActiveRecord::Base
  belongs_to :subject
  validates_presence_of :name
  validates_presence_of :subject_id
  
  def type
    workshop ? "Workshop" : "Class"
  end
end
