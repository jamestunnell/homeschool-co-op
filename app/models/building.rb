class Building < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_one :address, dependent: :destroy
  validates_presence_of :address
  accepts_nested_attributes_for :address
  
  has_many :rooms, dependent: :destroy
  has_many :events, dependent: :destroy
end
