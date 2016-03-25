require "test_helper"

class UsersControllerTest < ActionController::TestCase

  test "#signup" do
    process(:new, method: :get)

    assert_select "title", "Sign Up"
    assert_select "form"
    assert_select "input#user_username"
    assert_select "input#user_email"
    assert_select "input#user_password"
    assert_select "input#user_password_confirmation"
    assert_select "input.btn-success"
    assert render: :new
  end

  test "#create" do
    user_attributes = {
      "username"              => "John",
      "email"                 => "john@tcarc.com",
      "password"              => "1234abcd",
      "password_confirmation" => "1234abcd"
    }

    process(:create, method: :post, params: { user: user_attributes })

    user = User.last
    assert_equal "John", user.username
    assert_equal "john@tcarc.com", user.email
    assert redirect: root_path
  end

  test "unssuccesful create" do
    user_attributes = {
      "username"              => "",
      "email"                 => "",
      "password"              => "",
      "password_confirmation" => ""
    }

    process(:create, method: :post, params: { user: user_attributes })
    assert render: :new
  end

end
