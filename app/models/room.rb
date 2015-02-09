class Room < ActiveRecord::Base
  belongs_to :building
  validates_presence_of :name
end
