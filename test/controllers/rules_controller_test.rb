require 'test_helper'

class RulesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rules_index_url
    assert_response :success
  end

  test "should get show" do
    get rules_show_url
    assert_response :success
  end

  test "should get new" do
    get rules_new_url
    assert_response :success
  end

  test "should get create" do
    get rules_create_url
    assert_response :success
  end

  test "should get edit" do
    get rules_edit_url
    assert_response :success
  end

  test "should get update" do
    get rules_update_url
    assert_response :success
  end

  test "should get destroy" do
    get rules_destroy_url
    assert_response :success
  end

end
