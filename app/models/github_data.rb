class GithubData

  attr_accessor :number_starred_repos,
              :followers,
              :following,
              :organizations,
              :commit_info,
              :repos,
              :contributions_in_last_year,
              :longest_streak,
              :current_streak

  def initialize(params={})
    @number_starred_repos       = params[:number_starred_repos]
    @followers                  = params[:followers]
    @following                  = params[:following]
    @organization_names              = params[:organization_names]
    @commit_info                = params[:commit_info]
    @repos                      = params[:repos]
    @contributions_in_last_year = params[:contributions_in_last_year]
    @longest_streak             = params[:longest_streak]
    @current_streak             = params[:current_streak]
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
     obj.followers                  = attrs["followers"]
     obj.following                  = attrs["following"]
     obj.organizations              = attrs["organizations"]
     obj.commit_info                = attrs["commit_info"]
     obj.repos                      = attrs["repos"]
     obj.contributions_in_last_year = attrs["contributions_in_last_year"]
     obj.longest_streak             = attrs["longest_streak"]
     obj.current_streak             = attrs["current_streak"]
   end
   obj
  end

  def commits
    commit_info.map do |event|
      Commit.new(event["repo"], event["url"], event["commits"].count)
    end
  end

  def repositories
    if repos.empty?
      []
    else
      repos.map do |repo|
        Repository.new(repo)
      end
    end
  end

  def self.dump obj
    obj.to_json if obj
  end
end
