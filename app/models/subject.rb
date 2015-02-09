class Subject < ActiveRecord::Base
  has_many :courses, dependent: :destroy
  validates_presence_of :name
end
