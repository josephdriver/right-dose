require 'test_helper'

class CaseDrugsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get case_drugs_create_url
    assert_response :success
  end

end
