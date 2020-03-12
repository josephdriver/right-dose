class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  before_action :store_admin_location!, if: :storable_location?
  # before_action :authenticate_paramedic!
  include Pundit
  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def current_user
    current_admin || current_paramedic
  end

  def after_sign_in_path_for(resource)
    if resource.class == Admin
      admin_dashboard_path
    else
      paramedic_dashboard_path
    end
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] == 'dashboards' || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_admin_location!
    store_location_for(:admin, request.fullpath)
  end
end
