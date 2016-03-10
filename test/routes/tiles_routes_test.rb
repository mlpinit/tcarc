require "test_helper"

class TileRoutesTest < ActionDispatch::IntegrationTest

  test "tiles#create" do
    assert_routing({ method: "POST", path: "/tiles" }, { controller: "tiles", action: "create" })
  end

end
