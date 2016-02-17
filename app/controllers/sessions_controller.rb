class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by_auth(auth_hash)
    byebug
    if user
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
