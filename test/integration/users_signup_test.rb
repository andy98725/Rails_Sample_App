require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "Rejects Bad Signup" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: {
                  name: "", uName:"",
                  email: "user@invalid",
                  password: "foo",
                  password_confirmation: "bar"

                  }}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "Accepts Good Signup" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: {
                  name: "Bobby Joe", uName:"Sample123",
                  email: "example@railstutorial.com",
                  password: "fullPassword",
                  password_confirmation: "fullPassword"

                  }}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
