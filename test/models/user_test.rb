require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "#authenticate" do
    assert_equal users(:john), User.find_by(email: "john@test.com").authenticate("1234abcd")
    refute User.find_by(email: "john@test.com").authenticate("lalalala")
  end

end
