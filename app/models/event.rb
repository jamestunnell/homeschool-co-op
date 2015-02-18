class Event < ActiveRecord::Base
  belongs_to :building
  mount_uploader :photo, PhotoUploader

  validates_presence_of :title
  validates_length_of :title, :minimum => 1

  validates_presence_of :start_time
  validates_presence_of :end_time
  validate :end_time_not_before_start_time
  def end_time_not_before_start_time
    end_time >= start_time
  end

  scope :upcoming, -> { where("start_time > ?", Time.now) }
end
