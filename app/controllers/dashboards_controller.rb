class DashboardsController < ApplicationController
  before_action :authenticate_paramedic!, only: :paramedic_dashboard
  before_action :authenticate_admin!, only: :admin_dashboard

  def paramedic_dashboard
    @paramedic = current_paramedic
    @drugs = Drug.all
  end

  def admin_dashboard
    @admin = current_admin
    @organization = current_admin.organization
  end
end
