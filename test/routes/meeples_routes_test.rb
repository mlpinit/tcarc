require "test_helper"

class MeeplesRoutesTest < ActionDispatch::IntegrationTest

  test "meeples#create" do
    assert_routing({ method: "POST", path: "/tiles" }, { controller: "tiles", action: "create" })
  end

end
