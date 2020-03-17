class CaseDrugsController < ApplicationController
  skip_after_action :verify_authorized
  before_action :authenticate_paramedic!, only: [:new, :create]

  def new
    @case_drug = CaseDrug.new

    @drug = Drug.find(drug_params[:drug_id])
    @presentations = @drug.presentations
    @rules = Rule.where(drug_id: @drug.id)
    @routes = []
    @indictations = []
    @rules.each do |rule|
      @indications << rule.indication unless @indications.include?
      @routes << rule.route unless @routes.include?
    end
  end

  def create
    byebug

    indication_param = params.require(:indication).permit(:indication_id)
    route_param = params.require(:route).permit(:route_id)
    presentation_param = params.require(:presentation).permit(:presentation_id)

    @drug = Drug.find(drug_param[:drug_id])
    @presentation = Presentation.find(presentation_param[:presentation_id])
    @indication = Indication.find(indication_param[:indication_id])
    @route = Route.find(route_param[:route_id])
    @rule = Rule.find(indication_id: @indication.id, route_id: @route.id)

    @case_drug = CaseDrug.new(case_drug_param, rule_id: @rule.id)
    authorize @case_drug
  end

  private

  def drug_params
    params.require(:drug).permit(:drug_id)
  end

  def case_drugs_params
    params.require(:case_drug).permit(:case_id)
  end
end
