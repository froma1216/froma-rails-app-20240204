require "test_helper"

class SlotsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get slots_show_url
    assert_response :success
  end
end
