require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  setup do
    @rocks_a = sections(:rocks_a)
    @algebra_a = sections(:algebra_a)
    @algebra_b = sections(:algebra_b)
    @music_theory_a = sections(:music_theory_a)
  end
  
  test "fixtures are valid" do
    [@rocks_a,@algebra_a,@algebra_b,@music_theory_a].each do |fixt|
      assert fixt.valid?
    end
  end
  
  test "when destroyed, meeting day/time is also destroyed" do
    mdt_id = @rocks_a.meeting_day_time.id
    @rocks_a.destroy
    assert MeetingDayTime.where(:id => mdt_id).empty?
  end
  
  test "when destroyed, enrollments are also destroyed" do
    @algebra_a.enrollments.create(:student => students(:sue))
    @algebra_a.enrollments.create(:student => students(:joe))
    e_ids = @algebra_a.enrollments.ids
    @algebra_a.destroy
    e_ids.each {|e_id| assert Enrollment.where(:id => e_id).empty? }
  end
end
