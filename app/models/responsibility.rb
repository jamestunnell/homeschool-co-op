
class Responsibility < ActiveRecord::Base
  belongs_to :user
  
  KINDS = {
    coordination: 0, registration: 1,
    cataloging: 2, scheduling: 3
  }
  enum kind: KINDS

  validates_presence_of :start_date
  validates_presence_of :end_date
  
  include ActiveModel::Validations
  validates_with EndDateValidator
  
  scope :upcoming, -> { where("start_date > ?", Date.today) }
  scope :past, -> { where("end_date <= ?", Date.today) }
  scope :not_past, -> { where("end_date > ?", Date.today) }
  scope :active, -> { where("start_date <= ? AND end_date > ?", Date.today, Date.today) }

  def active?
    t = Date.today
    start_date <= t && end_date > t
  end

  def past?
    Date.today >= end_date
  end
end
