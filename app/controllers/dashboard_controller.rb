class DashboardController < ApplicationController
  before_action :redirect_unauthenticated_users

  def show
    update_githubdata_for_new_user
    @user = DashboardPresenter.new(current_user, view_context)
  end

  private

  def update_githubdata_for_new_user
    if current_user.created_at == current_user.updated_at
      attributes = GithubService.new(current_user).attributes
      githubdata = GithubData.new(attributes)
      current_user.update_attribute("githubdata", githubdata)
      current_user.save
    end
  end

  def redirect_unauthenticated_users
    unless current_user
      redirect_to root_path
    end
  end
end
