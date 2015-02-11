require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @sam = users(:sam)
    @josie = users(:josie)
  end
  
  test "fixtures are valid" do
    assert @sam.valid?
    assert @josie.valid?
  end
  
  test "not valid without email" do
    @sam.email = nil
    assert_not @sam.valid?
  end
  
  test "email format must be valid" do
    ["uglyduck","uglyduck@","uglyduck.abc"].each do |str|
      @sam.email = str
      assert_not @sam.valid?
    end
  end
  
  test "not valid without first name" do
    @sam.first = nil
    assert_not @sam.valid?
  end
  
  test "not valid if first is shorter than MIN_NAME_LENGTH or longer than MAX_NAME_LENGTH" do
    @sam.first = "A"*(User::MIN_NAME_LENGTH-1)
    assert_not @sam.valid?
    
    @sam.first = "A"*(User::MAX_NAME_LENGTH+1)
    assert_not @sam.valid?
  end
  
  test "not valid without last name" do
    @sam.last = nil
    assert_not @sam.valid?
  end

  test "not valid if last is shorter than MIN_NAME_LENGTH or longer than MAX_NAME_LENGTH" do
    @sam.last = "A"*(User::MIN_NAME_LENGTH-1)
    assert_not @sam.valid?
    
    @sam.last = "A"*(User::MAX_NAME_LENGTH+1)
    assert_not @sam.valid?
  end
  
  test "full_name starts with first name" do
    assert_equal((Regexp.new(@sam.first) =~ @sam.full_name), 0)
  end
  
  test "full_name ends with last name" do
    assert((Regexp.new(@sam.last) =~ @sam.full_name) >= @sam.first.size)
  end
  
  test "when destroyed, students are also destroyed" do
    @sam.students.build(:first => "Addy", :birth_date => "2005-05-01")
    @sam.students.build(:first => "John", :birth_date => "2001-01-01")
    ids = @sam.students.ids
    @sam.destroy
    ids.each {|id| assert Student.where(id: id).empty? }
  end
  
  test "when destroyed, responsibilities are also destroyed" do
    @sam.responsibilities.build(kind: :coordination, :start_date => Date.today, :end_date => Date.today+1)
    @sam.responsibilities.build(kind: :registration, :start_date => Date.today, :end_date => Date.today+1)
    ids = @sam.students.ids
    @sam.destroy
    ids.each {|id| assert Responsibility.where(id: id).empty? }
  end
end
