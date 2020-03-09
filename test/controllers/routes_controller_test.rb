require 'test_helper'

class RoutesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get routes_new_url
    assert_response :success
  end

  test "should get create" do
    get routes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get routes_destroy_url
    assert_response :success
  end

end
