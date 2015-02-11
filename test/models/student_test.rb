require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  setup do
    @sue = students(:sue)
    @joe = students(:joe)
  end
  
  test "fixtures are valid" do
    [@sue,@joe,].each {|fixt| assert fixt.valid?}
  end
  
  test "not valid without a first name" do
    @joe.first = nil
    assert_not @joe.valid?
  end
  
  test "valid without a last name" do
    @joe.last = nil
    assert @joe.valid?
  end
  
  test "parent is alias for user" do
    assert_equal @joe.parent, @joe.user
    assert_equal @sue.parent, @sue.user
  end
  
  test "when destroyed, enrollments are also destroyed" do
    @joe.enrollments.create(:section => sections(:music_theory_a))
    @joe.enrollments.create(:section => sections(:algebra_a))
    e_ids = @joe.enrollments.ids
    @joe.destroy
    e_ids.each {|e_id| assert Enrollment.where(:id => e_id).empty? }
  end
  
  test "full_name starts with first name" do
    assert_equal((Regexp.new(@joe.first) =~ @joe.full_name), 0)
  end
  
  test "full_name uses last name if present and not empty" do
    @joe.last = "Montana"
    assert(Regexp.new(@joe.last) =~ @joe.full_name)
  end

  test "full_name uses parent's name if present and empty" do
    @joe.last = ""
    @joe.parent.last = "Blow"
    assert(Regexp.new(@joe.parent.last) =~ @joe.full_name)
  end
  
  test "full_name uses parent's name if not present" do
    @joe.last = nil
    @joe.parent.last = "Blow"
    assert(Regexp.new(@joe.parent.last) =~ @joe.full_name)
  end
end
