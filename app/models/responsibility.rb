class Responsibility < ActiveRecord::Base
  belongs_to :user
  
  KINDS = {
    coordination: 0, registration: 1,
    cataloging: 2, scheduling: 3
  }
  enum kind: KINDS
  
  def active?
    d = Date.today
    d >= start_date && d < end_date
  end
end
