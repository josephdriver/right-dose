class ParamedicTypesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @paramedic_types = policy_scope(ParamedicType)
  end

  def new
    @paramedic_type = ParamedicType.new(paramedic_type_params)
    authorize @paramedic_type
  end

  def create
    @paramedic_type = ParamedicType.new(paramedic_type_params)
    @paramedic_type.organization = current_admin.organization
    authorize @paramedic_type
    if @paramedic_type.save
      redirect_to paramedic_types_path
    else
      flash[:alert] = 'scope not saved'
      redirect_to paramedic_types_path
    end
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
    @paramedic_type = ParamedicType.find(params[:id])
    authorize @paramedic_type
    @paramedic_type.destroy
    redirect_to paramedic_types_path
  end

  private

  def paramedic_type_params
    params.require(:paramedic_type).permit(:title, :acronym, :photo)
  end
end
