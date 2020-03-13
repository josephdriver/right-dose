class OrganizationsController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  def edit
    @organization = current_admin.organization
    authorize @organization
  end

  def update
    @organization = Organization.find(params[:id])
    authorize @organization
    @organization.update(organization_params)
    redirect_to admin_dashboard_path
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :photo, :location, :pediatric_cutoff, :multiplier, :addition_num, :weight_6mth, :weight_3mth, :weight_unit)
  end
end
