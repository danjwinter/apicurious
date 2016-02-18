class DashboardController < ApplicationController
  def show
    update_githubdata_for_new_user
    @user = DashboardPresenter.new(current_user, view_context)

  end

  private

  def update_githubdata_for_new_user
    if current_user.githubdata.new_user
      attributes = GithubService.new(current_user).attributes
      githubdata = GithubData.new(attributes)
      current_user.update_attribute("githubdata", githubdata)
      current_user.save
    end
  end
end
