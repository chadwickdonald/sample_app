require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post users_path, user: { name: "",
  														 email: "user@invalid",
  														 password: "foobar",
  														 password_confirmation: "foobar" }
  	end
  	assert_template 'users/new'
  end

  test "valid signup information" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post_via_redirect users_path, user: { name: "Donkey Fatass",
  																					email: "donkey@fun.net",
  													  							password: "donkeyfoo",
  																					password_confirmation: "donkeyfoo" }
  	end
  	assert_template 'users/show'
  end

end
