class CaseDrugsController < ApplicationController
  skip_after_action :verify_authorized
  before_action :authenticate_paramedic!, only: [:new, :create]

  def index
    @rules = Rule.all.where(paramedic_id: current_medic.paramedic_type)
  end

  def update_form

  end

  def create

    @medic_type = current_paramedic.paramedic_type
    @drug = Drug.find(drug_params[:drug_id])

    pres_params = params.require(:presentation).permit(:presentation_id)
    indi_params = params.require(:indication).permit(:indication_id)
    rout_params = params.require(:route).permit(:route_id)

    @presentation = Presentation.find(pres_params[:presentation_id])
    byebug


    @drug.presentations.where(id: @presentation.id)
byebug
    @case_drug = CaseDrug.new(case_drug_params)
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
