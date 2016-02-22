require "test_helper"

class SessionsControllerTest < ActionController::TestCase

  test "successful sigin" do
    process(:create, method: :post, params: { email: "john@test.com", password: "1234abcd" })
    assert redirect_to: root_path
  end

  test "unsuccessful signin - wrong password" do
    process(:create, method: :post, params: { email: "john@test.com", password: "bad passowrd" })
    assert_equal flash[:error], "Wrong password/email combination."
    assert render: :new
  end

  test "unsuccessful signin - non-xistent user" do
    process(:create, method: :post, params: { email: "", password: "" })
    assert_equal flash[:error], "Wrong password/email combination."
    assert render: :new
  end

  test "#new" do
    process(:new, method: :get)
    assert_select "title", "Sign In"
    assert_select "form"
    assert_select "input#email"
    assert_select "input#password"
    assert_select "input.btn-success"
    assert render: :new
  end

end
