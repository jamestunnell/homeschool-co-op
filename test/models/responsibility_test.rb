require 'test_helper'

class ResponsibilityTest < ActiveSupport::TestCase
  setup do
    @sam_coordinates = responsibilities(:sam_coordinates)
    @josie_schedules = responsibilities(:josie_schedules)
  end
  
  test "fixtures are valid" do
    [@sam_coordinates,@josie_schedules].each {|fixt| assert fixt.valid? }
  end
  
  test "raises exception with invalid kind" do
    assert_raise ArgumentError do
      Responsibility.new(:kind => "froofroo")
    end
  end
  
  test "must have start date" do
    @sam_coordinates.start_date = nil
    assert_not @sam_coordinates.valid?
  end
  
  test "must have end date" do
    @sam_coordinates.end_date = nil
    assert_not @sam_coordinates.valid?
  end
  
  test "end date must be >= end date" do
    @sam_coordinates.end_date = @sam_coordinates.start_date
    assert @sam_coordinates.valid?
    
    @sam_coordinates.end_date = @sam_coordinates.start_date-1
    assert_not @sam_coordinates.valid?
  end
  
  test "scope :past" do
    a = Responsibility.create(:kind => "coordination", :start_date => Date.today-20, :end_date => Date.today-10)
    a.save
    b = Responsibility.create(:kind => "scheduling", :start_date => Date.today-20, :end_date => Date.today-2)
    b.save
    c = Responsibility.create(:kind => "coordination", :start_date => Date.today-20, :end_date => Date.today+20)
    c.save
    assert_not Responsibility.past.where(:id => a.id).empty?
    assert_not Responsibility.past.where(:id => b.id).empty?
    assert Responsibility.past.where(:id => c.id).empty?
  end
  
  test "scope :upcoming" do
    a = Responsibility.create(:kind => "coordination", :start_date => Date.today+20, :end_date => Date.today+21)
    a.save
    b = Responsibility.create(:kind => "scheduling", :start_date => Date.today+1, :end_date => Date.today+40)
    b.save
    c = Responsibility.create(:kind => "coordination", :start_date => Date.today-20, :end_date => Date.today-2)
    c.save
    assert_not Responsibility.upcoming.where(:id => a.id).empty?
    assert_not Responsibility.upcoming.where(:id => b.id).empty?
    assert Responsibility.upcoming.where(:id => c.id).empty?
  end
  
  test "scope :not_past" do
    a = Responsibility.create(:kind => "coordination", :start_date => Date.today+20, :end_date => Date.today+21)
    a.save
    b = Responsibility.create(:kind => "scheduling", :start_date => Date.today-5, :end_date => Date.today+40)
    b.save
    c = Responsibility.create(:kind => "coordination", :start_date => Date.today-20, :end_date => Date.today-2)
    c.save
    assert_not Responsibility.not_past.where(:id => a.id).empty?
    assert_not Responsibility.not_past.where(:id => b.id).empty?
    assert Responsibility.not_past.where(:id => c.id).empty?
  end
  
  test "scope :active" do
    a = Responsibility.create(:kind => "coordination", :start_date => Date.today-20, :end_date => Date.today+2)
    a.save
    b = Responsibility.create(:kind => "scheduling", :start_date => Date.today-5, :end_date => Date.today+40)
    b.save
    c = Responsibility.create(:kind => "coordination", :start_date => Date.today-20, :end_date => Date.today-2)
    c.save
    assert_not Responsibility.active.where(:id => a.id).empty?
    assert_not Responsibility.active.where(:id => b.id).empty?
    assert Responsibility.active.where(:id => c.id).empty?
  end
end
