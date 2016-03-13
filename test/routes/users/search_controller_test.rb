require "test_helper"

class Users::SearchRoutesTest < ActionDispatch::IntegrationTest

  test "useres/search#index" do
    assert_routing(
      { method: "GET", path: "/users/search" },
      { controller: "users/search", action: "index", format: "json"}
    )
  end

end
