class RulesController < ApplicationController
  skip_after_action :verify_authorized
  skip_before_action :authenticate_admin!

  def index
    @rule = policy_scope(Rule)
  end

  def search
    @drug = Drug.find(params[:drug_id])
    @paramedic_type = ParamedicType.all[0]
    @age = 7
    @pediatric_cutoff = 12
    if params[:drug]
      rules = @drug.rules.where(paramedic_type: @paramedic_type)
      rules_presentation = rules.select { |rule| rule.indication.presentation == Presentation.find(params[:drug][:presentation_ids]) }
      rules_indication = rules_presentation.select { |rule| rule.indication == Indication.find(params[:drug][:indication_ids]) }
      rules_route = rules_indication.select { |rule| rule.route == Route.find(params[:other][:routes]) }

      @final_rules = if @age > @pediatric_cutoff
        @calculation_type = "Age"
        adult_rules = rules_route.select { |rule| rule.patient_type == "Adult" }
        if adult_rules.nil?
        else
          adult_rules
        end
      elsif @age <= @pediatric_cutoff
        pediatric_rules = rules_route.select { |rule| rule.patient_type == "Pediatric"}
        if pediatric_rules.nil?
        else pediatric_rules
        end
      end
    end

  end

  def show

  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
