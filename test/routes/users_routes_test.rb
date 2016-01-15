require "test_helper"

class UsersRoutesTest < ActionDispatch::IntegrationTest

  test "users#signup" do
    assert_routing "/signup", controller: "users", action: "new"
  end

  test "users#create" do
    assert_routing({ method: "POST", path: "/users" }, { controller: "users", action: "create" })
  end

end
