class RulesController < ApplicationController
  skip_after_action :verify_authorized
  skip_before_action :authenticate_admin!

  def index
    @paramedic_type = ParamedicType.find(params[:paramedic_type])
    @rule = policy_scope(Rule).where(paramedic_type: @paramedic_type)
  end

  def search
    @drug = Drug.find(params[:drug_id])
    @paramedic_type = ParamedicType.find(params[:drug][:paramedic_type_id])
    @case = Case.find(params[:drug][:case_id])
    @presentation = Presentation.find(params[:other][:presentation_id])
    @indication = Indication.find(params[:other][:indication_id])
    @route = Route.find(params[:other][:route_id])
    @age = @case.age
    @pediatric_cutoff = @paramedic_type.organization.pediatric_cutoff

    byebug
    if params[:drug]
      rules = @drug.rules.where(paramedic_type: @paramedic_type)
      rules_presentation = rules.select { |rule| rule.indication.presentation == @presentation }
      rules_indication = rules_presentation.select { |rule| rule.indication == @indication }
      rules_route = rules_indication.select { |rule| rule.route == @route }

      if @age > @pediatric_cutoff
        @final_rules = rules_route.select { |rule| rule.patient_type == "Adult" }

      elsif @age <= @pediatric_cutoff
        @final_rules = rules_route.select { |rule| rule.patient_type == "Pediatric" }

      end
    end
    @case_drug = CaseDrug.create(drug_id: @drug.id, rule_id: @final_rule.id)
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

