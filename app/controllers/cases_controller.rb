class CasesController < ApplicationController
  def new
    @case = Case.new
    authorize @case
  end

  def create
    @case = Case.new(case_params)
    @case.user = current_user
    raise
    if @case.save
      # redirect_to paramedic_dashboard_path(@case)
    else
      render 'new'
    end
  end

  def show
  end

  private

  def case_params
    params.require(:case).permit(:age, :weight)
  end
end
