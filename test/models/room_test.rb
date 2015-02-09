require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test "not valid without a name" do
    r = rooms(:ballroom)
    r.name = nil
    assert_not r.valid?
  end
  
  test "has building reference" do
    r = rooms(:ballroom)
    assert_equal r.building, buildings(:oddfellows)
  end
end
