
require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
    remember(@user)
  end

  test "current_user returns user from good remember" do
    assert_equal @user, current_user
    assert logged_in?
  end

  test "current_user returns nil for bad remember" do
    @user.update_attribute(:remember_digest, User.digest(User.newtoken))
    assert_nil current_user
  end

end