require 'test_helper'

class MeetingDayTimeTest < ActiveSupport::TestCase
  setup do
    @rocks_a=meeting_day_times(:rocks_a)
    @algebra_a=meeting_day_times(:algebra_a)
    @algebra_b=meeting_day_times(:algebra_b)
    @music_theory_a=meeting_day_times(:music_theory_a)
  end
  
  test "fixtures are valid" do
    [@rocks_a,@algebra_a,@algebra_b,@music_theory_a].each do |fixt|
      assert fixt.valid?
    end
  end
  
  test "is not valid without start_time" do
    @rocks_a.start_time = nil
    assert_not @rocks_a.valid?
  end
  
  test "is not valid without end_time" do
    @rocks_a.end_time = nil
    assert_not @rocks_a.valid?
  end
  
  test "start_str method prints in 12-hr format" do
    mdt = MeetingDayTime.new(:start_time => "15:39".to_time)
    assert(/3:39PM/ =~ mdt.start_str)
  end
  
  test "end_str method prints in 12-hr format" do
    mdt = MeetingDayTime.new(:end_time => "15:39".to_time)
    assert(/3:39PM/ =~ mdt.end_str)
  end
end
