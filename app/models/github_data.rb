class GithubData
  attr_reader :number_starred_repos,
              :followers,
              :following,
              :organizations,
              :commit_info,
              :repos,
              :contributions_in_last_year,
              :longest_streak,
              :current_streak

  def initialize(params)
    @number_starred_repos
    @followers
    @following
    @organizations
    @commit_info
    @repos
    @contributions_in_last_year
    @longest_streak
    @current_streak
  end

end
