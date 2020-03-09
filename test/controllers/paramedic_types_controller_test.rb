require 'test_helper'

class ParamedicTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get paramedic_types_new_url
    assert_response :success
  end

  test "should get create" do
    get paramedic_types_create_url
    assert_response :success
  end

  test "should get destroy" do
    get paramedic_types_destroy_url
    assert_response :success
  end

end
