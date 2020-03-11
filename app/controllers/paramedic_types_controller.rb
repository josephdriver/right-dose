class ParamedicTypesController < ApplicationController
  def new
  end

  def index
    @paramedic_types = policy_scope(ParamedicType)
  end

  def create
  end

  def destroy
  end
end
