require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @sam = users(:sam)
    @josie = users(:josie)
    @joe = User.create(:first => "Joe", :last => "Blow",
                       :phone => "3605681234", :emergency_name => "Bill",
                       :emergency_phone => "3605671235",
                       :email => "mememe@ggg.com", :password => "12345678")
    @joe.save
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
  
  test "email must be unique" do
    @sam.email = @josie.email
    assert_not @sam.valid?
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

  # test "not valid without phone number" do
  #   @sam.phone = nil
  #   assert_not @sam.valid?
  # end

  # test "not valid without emergency name" do
  #   @sam.emergency_name = nil
  #   assert_not @sam.valid?
  # end

  # test "not valid without emergency phone number" do
  #   @sam.emergency_phone = nil
  #   assert_not @sam.valid?
  # end

  test "phone number must have correct format" do
    @sam.phone = "360568123"
    assert_not @sam.valid?

    @sam.phone = "360568123z"
    assert_not @sam.valid?
  end

  test "emergency phone number must have correct format" do
    @sam.emergency_phone = "360568123"
    assert_not @sam.valid?

    @sam.emergency_phone = "360568123z"
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
  
  
  test "active_responsibilities returns all responsibilities that are active (and none that are not)" do
    @joe.responsibilities.create(kind: :coordination, :start_date => Date.today-10, :end_date => Date.today+10)
    @joe.responsibilities.create(kind: :registration, :start_date => Date.today-20, :end_date => Date.today+1)
    @joe.responsibilities.create(kind: :scheduling, :start_date => Date.today+5, :end_date => Date.today+10)
    @joe.responsibilities.create(kind: :cataloging, :start_date => Date.today-20, :end_date => Date.today-2)
    ars = @joe.active_responsibilities
    kinds = ars.map{|ar| ar.kind }
    assert_equal ars.count, 2
    assert kinds.include?("coordination")
    assert kinds.include?("registration")
  end
  
  test "can_coordinate? returns true only if an active responsibility is coordination" do
    assert_not @joe.can_coordinate?
    @joe.responsibilities.create(kind: :coordination, :start_date => Date.today-10, :end_date => Date.today+10)
    assert @joe.can_coordinate?
  end
  
  test "can_register? returns true only if an active responsibility is registration" do
    assert_not @joe.can_register?
    @joe.responsibilities.create(kind: :registration, :start_date => Date.today-10, :end_date => Date.today+10)
    assert @joe.can_register?
  end
  
  test "can_schedule? returns true only if an active responsibility is scheduling" do
    assert_not @joe.can_schedule?
    @joe.responsibilities.create(kind: :scheduling, :start_date => Date.today-10, :end_date => Date.today+10)
    assert @joe.can_schedule?
  end

  test "can_catalog? returns true only if an active responsibility is cataloging" do
    assert_not @joe.can_catalog?
    @joe.responsibilities.create(kind: :cataloging, :start_date => Date.today-10, :end_date => Date.today+10)
    assert @joe.can_catalog?
  end
end
