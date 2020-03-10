class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.class == Admin
      admin_dashboard_path
    else
      paramedic_dashboard_path
    end
  end
end
