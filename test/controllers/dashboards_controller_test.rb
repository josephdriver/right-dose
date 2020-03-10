require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get paramedic_dashboard" do
    get dashboards_paramedic_dashboard_url
    assert_response :success
  end

  test "should get admin_dashboard" do
    get dashboards_admin_dashboard_url
    assert_response :success
  end

end
