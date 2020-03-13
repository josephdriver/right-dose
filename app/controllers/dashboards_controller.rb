class DashboardsController < ApplicationController
  before_action :authenticate_paramedic!, only: :paramedic_dashboard
  before_action :authenticate_admin!, only: :admin_dashboard

  def paramedic_dashboard
    @paramedic = current_paramedic
    # CREATE A NEW CASE WHEN THE DASHBOARD IS OPENED
    @case = Case.create!(paramedic_id: @paramedic.id)
    @drugs = Drug.all
    @routes = Route.all
    @final_rules = []
    @available_drugs = current_paramedic.rules.map { |rule| rule.drug }.uniq

    if params[:drug]
      @drug = Drug.find(params[:drug][:drug_id])
      @paramedic_type = current_paramedic.paramedic_type
      @age = 7
      @pediatric_cutoff = 12
      if params[:drug]
        rules = @drug.rules.where(paramedic_type: @paramedic_type)
        rules_presentation = rules.select { |rule| rule.indication.presentation == Presentation.find(params[:drug][:presentation_ids]) }
        rules_indication = rules_presentation.select { |rule| rule.indication == Indication.find(params[:drug][:indication_ids]) }
        rules_route = rules_indication.select { |rule| rule.route == Route.find(params[:other][:routes]) }

        if @age > @pediatric_cutoff
          final_rule = rules_route.select { |rule| rule.patient_type == "Adult" }
        elsif @age <= @pediatric_cutoff
          final_rule = rules_route.select { |rule| rule.patient_type == "Pediatric"}
          final_rule = final_rule.select do |rule|
            rule.min_age <= @age && rule.max_age >= @age
          end
        end
      end
    end
  end

  def admin_dashboard
    @admin = current_admin
    @organization = current_admin.organization
  end
end
