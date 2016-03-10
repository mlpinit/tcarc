require "test_helper"

class MeeplesRoutesTest < ActionDispatch::IntegrationTest

  test "meeples#create" do
    assert_routing({ method: "POST", path: "/meeples" }, { controller: "meeples", action: "create" })
  end

end
