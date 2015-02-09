require 'test_helper'

class TermTest < ActiveSupport::TestCase
  setup do
    @fallw2014 = terms(:fallw2014)
    @fallq2014 = terms(:fallq2014)
    @springq2015 = terms(:springq2015)
  end
  
  test "valid fixtures" do
    @fallq2014.valid?
    @fallw2014.valid?
  end
  
  test "must have start date" do
    @fallq2014.start_date = nil
    assert_not @fallq2014.valid?
  end
  
  test "must have end date" do
    @fallq2014.end_date = nil
    assert_not @fallq2014.valid?
  end
  
  test "end date must be >= end date" do
    @fallq2014.end_date = @fallq2014.start_date
    assert @fallq2014.valid?
    
    @fallq2014.end_date = @fallq2014.start_date-1
    assert_not @fallq2014.valid?
  end
  
  test "weeks_long method" do
    assert ((@fallq2014.weeks_long * 7) - @fallq2014.days_long).abs < 7
  end
  
  test "start_season_year method" do
    {
      @fallq2014 => "Fall 2014",
      @fallw2014 => "Fall 2014",
      @springq2015 => "Spring 2015",
      Term.new(:start_date => "2013-01-05") => "Winter 2013",
      Term.new(:start_date => "2013-12-31") => "Winter 2014"
    }.each do |term,str|
      assert_equal term.start_season_year, str
    end
  end
end
