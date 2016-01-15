require "test_helper"

class UsersControllerTest < ActionController::TestCase

  test "#signup" do
    get :new

    assert_select "title", "Sign Up"
    assert_select "form"
    assert_select "input#user_name"
    assert_select "input#user_email"
    assert_select "input#user_password"
    assert_select "input#user_password_confirmation"
    assert_select "input.btn-success"
    assert render: :new
  end

  test "#create" do
    user_attributes = {
      "name"                  => "John",
      "email"                 => "john@famapp.com",
      "password"              => "1234abcd",
      "password_confirmation" => "1234abcd"
    }

    post :create, user: user_attributes

    user = User.last
    assert_equal "John", user.name
    assert_equal "john@famapp.com", user.email
    assert redirect: root_path
  end

  test "unssuccesful create" do
    user_attributes = {
      "name"                  => "",
      "email"                 => "",
      "password"              => "",
      "password_confirmation" => ""
    }

    post :create, user: user_attributes
    assert render: :new
  end

end
