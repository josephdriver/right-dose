class ParamedicsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @paramedics = policy_scope(Paramedic)
  end

  def destroy
  end
end
