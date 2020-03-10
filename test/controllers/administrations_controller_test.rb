require 'test_helper'

class AdministrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administrations_index_url
    assert_response :success
  end

  test "should get show" do
    get administrations_show_url
    assert_response :success
  end

  test "should get new" do
    get administrations_new_url
    assert_response :success
  end

  test "should get create" do
    get administrations_create_url
    assert_response :success
  end

end
