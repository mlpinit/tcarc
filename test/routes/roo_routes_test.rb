require "test_helper"

class RootRoutesTest < ActionDispatch::IntegrationTest

  test "root" do
    assert_routing "/", controller: "home", action: "index"
  end

end
