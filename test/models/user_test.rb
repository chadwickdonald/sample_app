require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
  	@user = User.new(name: "Bill Donkey", email: "bill@fun.org",
  		password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "      "
  	assert_not @user.valid?
  end

  test "email should be preset" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "b"*51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "b"*248 + "@fun.org"
  	assert_not @user.valid?
  end

  test "email validation should accept valid emails" do
  	valid_emails = %w[user@example.com USER@foo.COM A-US_ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_emails.each do |valid_email|
  		@user.email = valid_email
  		assert @user.valid?, "#{valid_email.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid emails" do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
    	@user.email = invalid_address
    	assert_not @user.valid?, "#{invalid_address.inspect} should not be valid"
    end
  end

	test "email addresses should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
  end

  test "password should have a minimum length" do
  	@user.password = @user.password_confirmation = "a"*5
  	assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

end











