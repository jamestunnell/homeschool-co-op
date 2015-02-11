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
    [@fallq2014,@fallw2014,@springq2015].each do |term|
      assert ((term.weeks_long * 7) - term.days_long).abs < 7
    end
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
  
  test "when destroyed, sections are also destroyed" do
    assert_not @fallq2014.sections.empty?
    s_ids = @fallq2014.sections.ids
    @fallq2014.destroy
    s_ids.each {|s_id| assert Section.where(:id => s_id).empty? }
  end
end
