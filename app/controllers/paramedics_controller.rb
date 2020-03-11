class ParamedicsController < ApplicationController
  def new
    @paramedic = Paramedic.new
    authorize @paramedic
  end

  def create
  end

  def index
    @paramedics = policy_scope(Paramedic)
  end

  def destroy
  end
end
