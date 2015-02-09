require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    @algebra = courses(:algebra)
    @rocks = courses(:rocks)
    @music_theory = courses(:music_theory)
  end
  
  test "fixtures are valid" do
    [@algebra, @rocks, @music_theory].each {|f| assert f.valid? }
  end
  
  test "type method" do
    assert_equal @algebra.type, "Class"
    assert_equal @rocks.type, "Workshop"
  end
  
  test "name must be present" do
    @algebra.name = nil
    assert_not @algebra.valid?
  end
  
  test "description is optional" do
    @algebra.description = nil
    assert @algebra.valid?
  end
  
  test "must reference subject" do
    @algebra.subject_id = nil
    assert_not @algebra.valid?
  end
end
