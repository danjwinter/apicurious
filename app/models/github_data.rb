class GithubData

  attr_accessor :number_starred_repos,
              :followers_count,
              :following_count,
              :organizations,
              :commit_info,
              :repos,
              :contributions_in_last_year,
              :longest_streak,
              :current_streak,
              :new_user

  def initialize(params={})
    @new_user = params.empty? ? true : false
    @number_starred_repos       = params[:number_starred_repos]
    @followers_count                  = params[:followers_count]
    @following_count                  = params[:following_count]
    @organizations              = params[:organizations]
    @commit_info                = params[:commit_info]
    @repos                      = params[:repos]
    @contributions_in_last_year = params[:contributions_in_last_year]
    @longest_streak             = params[:longest_streak]
    @current_streak             = params[:current_streak]
  end


  def orgs
    organizations.map do |org|
      Organization.new(org)
    end
  end

  def commits
    commit_info.map do |event|
      Commit.new(repo: event["repo"],
                 url: event["url"],
                 commit_count: event["commits"].count,
                 date: event["date"])
    end
  end

  def repositories
    repos.map do |repo|
      Repository.new(repo)
    end
  end

  def serialize(attr_name, class_name = Object)
    coder = if [:load, :dump].all? { |x| class_name.respond_to?(x) }
      class_name
    else
      Coders::YAMLColumn.new(class_name)
    end
  end

  def self.load json
    obj = self.new
    unless json.nil?
      attrs = JSON.parse json
      obj.number_starred_repos       = attrs["number_starred_repos"]
      obj.followers_count                  = attrs["followers_count"]
      obj.following_count                  = attrs["following_count"]
      obj.organizations              = attrs["organizations"]
      obj.commit_info                = attrs["commit_info"]
      obj.repos                      = attrs["repos"]
      obj.contributions_in_last_year = attrs["contributions_in_last_year"]
      obj.longest_streak             = attrs["longest_streak"]
      obj.current_streak             = attrs["current_streak"]
    end
    obj
  end

  def self.dump obj
    obj.to_json if obj
  end
end
