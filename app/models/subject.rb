class Subject < ActiveRecord::Base
  has_many :courses, dependent: :destroy
end
