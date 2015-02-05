class Enrollment < ActiveRecord::Base
  belongs_to :enrollable, polymorphic: true
  belongs_to :section
end
