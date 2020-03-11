class DrugsController < ApplicationController
  def new
    @drug = Drug.new
    @presentation = Presentation.new
    authorize @drug
    authorize @presentation
  end

  def create
    @drug = Drug.new(drug_params)
    @drug.organization = current_admin.organization
    authorize @drug
    if @drug.save
      redirect_to drugs_path
    end
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

  private

  def drug_params
    params.require(:drug).permit(:name)
  end
end
