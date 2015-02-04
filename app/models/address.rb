class Address < ActiveRecord::Base
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  
  belongs_to :building
  enum state: ["AL","AK","AZ","AR","CA","CO","CT",
               "DE","FL","GA","HI","ID","IL","IN",
               "IA","KS","KY","LA","ME","MD","MA",
               "MI","MN","MS","MO","MT","NE","NV",
               "NH","NJ","NM","NY","NC","ND","OH",
               "OK","OR","PA","RI","SC","SD","TN",
               "TX","UT","VT","VA","WA","WV","WI",
               "WY"]
  
  def oneline
    "#{street} #{city}, #{state} #{zip}"
  end
end
