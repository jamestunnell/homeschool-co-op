class Course < ActiveRecord::Base
  belongs_to :subject
  validates_presence_of :name
  validates_presence_of :subject_id
  has_many :sections
  
  def type
    workshop ? "Workshop" : "Class"
  end
end
