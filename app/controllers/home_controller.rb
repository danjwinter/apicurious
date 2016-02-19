class HomeController < ApplicationController
  before_action :redirect_logged_in_user

  def show
  end

  private

  def redirect_logged_in_user
    if current_user
      redirect_to dashboard_path
    end
  end
end
