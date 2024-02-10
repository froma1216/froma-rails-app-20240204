require "test_helper"

class Mypage::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mypage_home_index_url
    assert_response :success
  end
end
