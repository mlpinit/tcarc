require "test_helper"

class SessionsRoutesTest < ActionDispatch::IntegrationTest

  test "sessions#new" do
    assert_routing "signin", controller: "sessions", action: "new"
  end

  test "sessions#create" do
    assert_routing({ method: "POST", path: "/sessions" }, { controller: "sessions", action: "create" })
  end

end
