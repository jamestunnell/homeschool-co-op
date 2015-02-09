require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  setup do
    @math = subjects(:math)
    @geol = subjects(:geol)
    @music = subjects(:music)
  end
  
  test "fixtures are valid" do
    [@math, @geol, @music].each {|f| assert f.valid? }
  end
  
  test "name must be present" do
    @math.name = nil
    assert_not @math.valid?
  end
  
  test "abbreviation is optional" do
    @math.abbrev = nil
    assert @math.valid?
  end
  
  test "has many courses, which are optional" do
    @math.courses.destroy_all
    assert @math.valid?
  end
  
  test "when destroyed, courses are also destroyed" do
    ids = @math.courses.map {|c| c.id }
    @math.destroy
    ids.each { |id| assert Course.where(:id => id).empty? }
  end
end
