class ParamedicTypesController < ApplicationController
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
    @paramedic_type.update(paramedic_type_params)
  end

  def destroy
  end

  private

  def paramedic_type_params
    params.require(:paramedic_type).permit(:title, :acronym)
  end
end
