class CasesController < ApplicationController
  def edit
    raise
    @case = Case.find(params[:case_id])
    authorize @case
  end

  def update
    @case = Case.new(case_params)
    authorize @case
    if @case.save
      redirect_to paramedic_dashboard_path
    else
      render 'new'
    end
  end

  def show
  end

  private

  def case_params
    params.require(:case).permit(:age, :weight, :paramedic_id)
  end
end
