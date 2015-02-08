class Responsibility < ActiveRecord::Base
  belongs_to :user
  
  KINDS = {
    coordination: 0, registration: 1,
    cataloging: 2, scheduling: 3
  }
  enum kind: KINDS
  
  scope :upcoming, -> { where("start_date > ?", Date.today) }
  scope :past, -> { where("end_date < ?", Date.today) }
  scope :not_past, -> { where("end_date >= ?", Date.today) }
  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.today, Date.today) }
  
  def active?
    d = Date.today
    d >= start_date && d < end_date
  end
end
