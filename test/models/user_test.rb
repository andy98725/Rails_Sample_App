require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Sample user to test
  def setup
    @user = User.new(name: "Example User", uName: "Sample",
          email: "user@example.com",
          password: "foobar", password_confirmation: "foobar")
    @user2 = User.new(name: "Other Example", uName: "Sequel",
          email: "other@example.com",
          password: "foobar", password_confirmation: "foobar")
  end

  test "Basic User valid" do
    assert @user.valid?
  end

  test "Name Required" do
    @user.name = "\t"
    assert !@user.valid?
  end

  test "Name Maximum Length" do
    @user.name = 'a' * 51
    assert !@user.valid?
  end


  test "Username Required" do
    @user.uName = "\n"
    assert !@user.valid?
  end

  test "Username Maximum Length" do
    @user.uName = 'a' * 51
    assert !@user.valid?
  end

  test "Username should be unique" do
    @user.save
    @user2.uName = @user.uName.upcase
    assert_not @user2.valid?

  end


  test "Email Required" do
    @user.email = " "
    assert !@user.valid?
  end

  test "Email Maximum Length" do
    @user.email = 'a' * 201
    assert !@user.valid?
  end

  test "Email Accepts valid" do
    valids = %w[user@example.org USER@foo.com
                A_US-ER@foo.org first+last@baz.jp]
    valids.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "Email Rejects invalid" do
    invalids = %w[user@example,org user_at_foo.org user.name@example.
                    foo@bar_baz.com foo@bar+baz.com]
    invalids.each do |address|
      @user.email = address
      assert !@user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "Emails should be unique" do
    @user.save
    @user2.email = @user.email
    assert_not @user2.valid?
  end

  test "Emails save in lowercase" do
    mixed = "Foo@eXamplE.COM"
    @user.email = mixed
    @user.save
    assert_equal mixed.downcase, @user.reload.email
  end


  test "Password should be nonblank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "Password should be min length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "Password should be max length" do
    @user.password = @user.password_confirmation = "a" * 71
    assert_not @user.valid?
  end

  test "Authenticate should fail with no cookies" do
    assert_not @user.authenticated?('')
  end
end
