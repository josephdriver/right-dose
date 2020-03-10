class PagesController < ApplicationController
  skip_before_action :authenticate_admin!
  skip_before_action :authenticate_paramedic!
  def home
  end
end
