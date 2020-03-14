class ParamedicTypesController < ApplicationController
  before_action :authenticate_admin!
  def new
  end

  def index
    @paramedic_types = policy_scope(ParamedicType)
  end

  def create
  end

  def edit
    @paramedic_type = ParamedicType.find(params[:id])
    authorize @paramedic_type
  end

  def update
    @paramedic_type = ParamedicType.find(params[:id])
    authorize @paramedic_type
    if @paramedic_type.update(paramedic_type_params)
      redirect_to paramedic_types_path
    else
      flash[:alert] = 'Updated did not succeed!'
      redirect_to paramedic_types_path
    end
  end

  def destroy
  end

  private

  def paramedic_type_params
    params.require(:paramedic_type).permit(:title, :acronym, :photo)
  end
end
