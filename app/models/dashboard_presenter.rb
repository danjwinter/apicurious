class DashboardPresenter < SimpleDelegator
  attr_reader :view, :model

  def initialize(model, view)
    @view = view
    @model = model
    super(@model)
  end

  def number_starred_repos
    githubdata.number_starred_repos
  end

  def number_followers
    githubdata.followers_count
  end

  def number_following
    githubdata.following_count
  end

  def contributions_in_last_year
    githubdata.contributions_in_last_year
  end

  def longest_streak
    githubdata.longest_streak
  end

  def current_streak
    githubdata.current_streak
  end

  def recent_commits
    githubdata.commits.first(10)
  end

  def repos
    githubdata.repositories
  end

  def organizations
    githubdata.orgs
  end
end
