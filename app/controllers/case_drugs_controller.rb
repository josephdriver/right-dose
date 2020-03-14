class CaseDrugsController < ApplicationController
  skip_after_action :verify_authorized

  def new
    raise
  end

  def create
    raise
    @case_drug.find(params[:id])
  end

  private

  def case_drugs_params
    params.require(:case_drug).permit(:case_id, :drug_id, :presentation, :indication, :route)
  end
end
