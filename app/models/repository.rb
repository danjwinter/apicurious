class Repository
  attr_reader :name,
              :url,
              :language,
              :forks_count,
              :stargazers_count

  def initialize(params)
    @name = params["name"]
    @url = params["url"]
    @language = params["language"]
    @forks_count = params["forks_count"]
    @stargazers_count = params["stargazers_count"]
  end
end
