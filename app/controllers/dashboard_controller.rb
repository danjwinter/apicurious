class DashboardController < ApplicationController
  def show
    byebug
    GithubService.new(current_user).followers
  end
end
