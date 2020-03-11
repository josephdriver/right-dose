class DrugsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @drugs = policy_scope(Drug)
    @admin = current_admin
  end

  def edit
  end

  def update
  end

  def destroy
    @drug = Drug.find(params[:id])
    authorize @drug
    @drug.destroy
    redirect_to drugs_path
  end
end
