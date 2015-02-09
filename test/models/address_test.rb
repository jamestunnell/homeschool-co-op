require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  setup do
    @oddfellows = addresses(:oddfellows)
    @oneline_str = @oddfellows.oneline
  end
  
  test "saves with valid attributes" do
    addr = Address.new(:street => "123 Easy St", :city => "Ritzville",
                       :state => "WA", :zip => "12345")
    assert addr.save
  end
  
  test "fixtures are valid" do
    assert @oddfellows.valid?
  end
  
  [:street,:city,:state,:zip].each do |attr_sym|
    test "setting #{attr_sym} to nil makes invalid" do
      @oddfellows.send("#{attr_sym}=".to_sym,nil)
      assert_not @oddfellows.valid?
    end
  end
  
  test "positions in one-line string" do
    positions = Hash[
      [:street,:city,:state,:zip].map do |attr_sym|
        [attr_sym, Regexp.new(@oddfellows.send(attr_sym)) =~ @oneline_str]
      end
    ]
    assert_equal positions[:street], 0
    assert positions[:city] >= @oddfellows.street.size
    assert positions[:state] >= (positions[:city] + @oddfellows.city.size)
    assert positions[:zip] >= (positions[:state] + @oddfellows.state.size)
  end
end
