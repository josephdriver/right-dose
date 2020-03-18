class DrugsController < ApplicationController
  def index
    @drugs = policy_scope(Drug)
    if params[:query].present?
      # sql_query = "name ILIKE :query"
      # @drugs = policy_scope(Drug).where(sql_query, query: "%#{params[:query]}%")
      @drugs = policy_scope(Drug).search(params[:query])
    else
      @drugs = policy_scope(Drug)
    end
  end

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
