class RulesController < ApplicationController
  skip_after_action :verify_authorized
  skip_before_action :authenticate_admin!

  def index
    @paramedic_type = ParamedicType.find(params[:paramedic_type])
    @rule = policy_scope(Rule).where(paramedic_type: @paramedic_type)
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

      if @age > @pediatric_cutoff
        @final_rules = rules_route.select { |rule| rule.patient_type == "Adult" }
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
    @rule = Rule.new
    authorize @rule
    @organization = current_admin.organization
    @paramedic_type = ParamedicType.find(params[:paramedic_type])
  end

  def create
    @rule = Rule.new(rule_params)
    @paramedic_type = ParamedicType.find(params[:rule][:paramedic_type_id])
    if params[:rule][:patient_type] == "Adult"
      @rule.calc_type = "Age based"
    end
     authorize @rule
    if @rule.save
      redirect_to paramedic_types_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def rule_params
    params.require(:rule).permit(:paramedic_type_id, :indication_id, :route_id, :calc_type, :patient_type, :min_initial_dose, :max_initial_dose, :dose_unit, :min_interval, :max_interval, :repeat_dose, :max_single_dose, :max_total_dose, :min_age, :max_age)
  end
end

