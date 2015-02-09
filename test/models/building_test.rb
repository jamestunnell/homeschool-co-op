require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  setup do
    @oddfellows = buildings(:oddfellows)
    @ldschurch = buildings(:ldschurch)
  end
  
  test "validity of fixtures" do
    assert @oddfellows.valid?
    assert @ldschurch.valid?
  end

  test "name must be present" do
    @oddfellows.name = nil
    assert_not @oddfellows.valid?
  end
  
  test "name must be unique" do
    @oddfellows.name = @ldschurch.name
    assert_not @oddfellows.valid?
  end
  
  test "has one address, which must be present" do
    @oddfellows.address = nil
    assert_not @oddfellows.valid?
  end
  
  test "when destroyed, address is also destroyed" do
    a_id = @oddfellows.address.id
    @oddfellows.destroy
    assert Address.where(:id => a_id).empty?
  end
  
  test "has many rooms, which are optional" do
    @oddfellows.rooms.destroy_all
    assert @oddfellows.valid?
  end
  
  test "when destroyed, rooms are also destroyed" do
    r_ids = @oddfellows.rooms.map {|r| r.id }
    @oddfellows.destroy
    r_ids.each { |r_id| assert Room.where(:id => r_id).empty? }
  end
end
