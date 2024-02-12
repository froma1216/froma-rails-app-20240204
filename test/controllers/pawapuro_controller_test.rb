require "test_helper"

class PawapuroControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pawapuro_index_url
    assert_response :success
  end

  test "should get new" do
    get pawapuro_new_url
    assert_response :success
  end

  test "should get create" do
    get pawapuro_create_url
    assert_response :success
  end

  test "should get edit" do
    get pawapuro_edit_url
    assert_response :success
  end

  test "should get update" do
    get pawapuro_update_url
    assert_response :success
  end

  test "should get destroy" do
    get pawapuro_destroy_url
    assert_response :success
  end
end
