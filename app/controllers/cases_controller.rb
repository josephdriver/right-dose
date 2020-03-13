class CasesController < ApplicationController
  def edit
    @case = Case.find(params[:case_id])
    authorize @case
    respond_to do |format|
      format.html { @case.save }
      format.js
    end
  end

  def update
    @case = Case.find(params[:id])
    authorize @case
    if @case.update(case_params)
      respond_to do |format|
        format.html { redirect_to paramedic_dashboard_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.js
      end
    end
  end

  def show
  end

  private

  def case_params
    params.require(:case).permit(:age, :weight, :paramedic_id)
  end
end
