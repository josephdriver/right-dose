class ParamedicsController < ApplicationController
  def index
    @paramedics = policy_scope(Paramedic)
    if params[:query].present?
      @paramedics = policy_scope(Paramedic).search(params[:query])
    else
      @paramedics = policy_scope(Paramedic)
    end
  end

  def new
    @paramedic = Paramedic.new
    authorize @paramedic
  end

  def create
    @paramedic = Paramedic.new(paramedic_params)
    authorize @paramedic
    if @paramedic.save
      redirect_to paramedics_path
    else
      redirect_to paramedics_path
      flash[:alert] = 'Paramedic did not save!'
    end
  end

  def edit
    @paramedic = Paramedic.find(params[:id])
    authorize @paramedic
  end

  def update
    @paramedic = Paramedic.find(params[:id])
    authorize @paramedic
    if @paramedic.update(paramedic_params)
      redirect_to paramedics_path
    else
      flash[:alert] = 'update failed'
      redirect_to paramedics_path
    end
  end

  def destroy
    @paramedic = Paramedic.find(params[:id])
    authorize @paramedic
    @paramedic.destroy
    redirect_to paramedics_path
  end

  private

  def paramedic_params
    params.require(:paramedic).permit(:id, :first_name, :last_name, :email, :employee_num, :password, :paramedic_type_id,
      cases_attributes: [:age, :weigh, :paramedic_id])
  end

end



