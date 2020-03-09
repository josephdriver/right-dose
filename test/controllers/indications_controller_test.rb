require 'test_helper'

class IndicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get indications_index_url
    assert_response :success
  end

  test "should get new" do
    get indications_new_url
    assert_response :success
  end

  test "should get create" do
    get indications_create_url
    assert_response :success
  end

  test "should get edit" do
    get indications_edit_url
    assert_response :success
  end

  test "should get update" do
    get indications_update_url
    assert_response :success
  end

  test "should get destroy" do
    get indications_destroy_url
    assert_response :success
  end

end
