class DashboardController < ApplicationController
  def show
    @user = DashboardPresenter.new(current_user, view_context)
    attributes = GithubService.new(current_user).attributes
    githubdata = GithubData.new(attributes)
    current_user.update_attribute("githubdata", githubdata)
    current_user.save
  end
end
