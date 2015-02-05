class Building < ActiveRecord::Base
  validates_presence_of :name
  
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  
  has_many :rooms, dependent: :destroy
end
