require 'test_helper'

class ParamedicsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get paramedics_new_url
    assert_response :success
  end

  test "should get create" do
    get paramedics_create_url
    assert_response :success
  end

  test "should get index" do
    get paramedics_index_url
    assert_response :success
  end

  test "should get destroy" do
    get paramedics_destroy_url
    assert_response :success
  end

end
