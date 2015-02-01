class Course < ActiveRecord::Base
  belongs_to :subject
  
  def has_subject?; !subject_id.nil?; end
end
