class ParamedicsController < ApplicationController
  def new
    @paramedic = Paramedic.new
    authorize @paramedic
  end

  def create
    @paramedic = Paramedic.new(paramedic_params)
    @paramedic.organization = current_admin.organization
    authorize @paramedic
    if @paramedic.save
      redirect_to paramedics_path
    end
  end

  def index
    @paramedics = policy_scope(Paramedic)
  end

  def destroy
    @paramedic = Paramedic.find(params[:id])
    authorize @paramedic
    @paramedic.destroy
    redirect_to paramedics_path
  end

  private

  def paramedic_params
    params.require(:paramedic).permit(:first_name, :last_name, :email, :employee_num,
      cases_attributes: [:age, :weigh, :paramedic_id])
  end

end



