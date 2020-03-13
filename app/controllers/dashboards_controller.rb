class DashboardsController < ApplicationController
  before_action :authenticate_paramedic!, only: :paramedic_dashboard
  before_action :authenticate_admin!, only: :admin_dashboard

  def paramedic_dashboard
    @paramedic = current_paramedic
    # CREATE A NEW CASE WHEN THE DASHBOARD IS OPENED
    @case = Case.create!(paramedic_id: @paramedic.id)
    @drugs = Drug.all
    @routes = Route.all
  end

  def admin_dashboard
    @admin = current_admin
    @organization = current_admin.organization
  end

  private

  # def medic_drugs
  #   drugs_arr = []
  #   Drug.all.each do |drug|
  #     drug.rules.each do |rule|
  #       next if drugs_arr.include?(drug)

  #       drugs_arr << drug if rule.paramedic_type_id == @paramedic.paramedic_type_id
  #     end
  #   end
  # end
end
