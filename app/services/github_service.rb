require 'open-uri'

class GithubService
  attr_reader :connection, :user

  def initialize(user)
    @connection ||= Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
    @user = user

    add_token_to_headers
  end

  def attributes
    {
      number_starred_repos: number_starred_repos,
      followers_count: followers_count,
      following_count: following_count,
      organizations: organizations,
      commit_info: commit_info,
      repos: repos,
      contributions_in_last_year: contributions_in_last_year,
      longest_streak: longest_streak,
      current_streak: current_streak
    }
  end

  def following_count
    following.count
  end

  def followers_count
    followers.count
  end

  def number_starred_repos
    starred_repos.count
  end

  def organizations
    org_data.map do |org|
      {name: org[:login], url: "https://github.com/#{org[:login]}"}
    end
  end

  def commit_info
    events = commit_data.map do |event|
      if event[:type] == "PushEvent"
        {repo: event[:repo][:name],
         url: "https://github.com/#{event[:repo][:name]}/commits?author=#{user.nickname}",
         date: event[:created_at],
         commits: grab_users_commits(event)}
      end
    end.compact
    compact_shas(events)
  end

  def repos
    repo_data.map do |repo|
      {name: repo[:name], url: repo[:html_url], language: repo[:language], forks_count: repo[:forks_count], stargazers_count: repo[:stargazers_count]}
    end
  end

  def contributions_in_last_year
    page = Nokogiri::HTML(open("https://github.com/#{user.nickname}"))
    page.xpath('//*[@id="contributions-calendar"]/div[3]/span[2]').text
  end

  def longest_streak
    page = Nokogiri::HTML(open("https://github.com/#{user.nickname}"))
    page.xpath('//*[@id="contributions-calendar"]/div[4]/span[2]').text
  end

  def current_streak
    page = Nokogiri::HTML(open("https://github.com/#{user.nickname}"))
    page.xpath('//*[@id="contributions-calendar"]/div[5]/span[2]').text
  end

  private

  def repo_data
    parse(connection.get("users/#{user.nickname}/repos"))
  end

  def commit_data
    parse(connection.get("users/#{user.nickname}/events"))
  end

  def org_data
    parse(connection.get("users/#{user.nickname}/orgs"))
  end

  def starred_repos
    parse(connection.get("users/#{user.nickname}/starred"))
  end

  def followers
    parse(connection.get("users/#{user.nickname}/followers"))
  end

  def following
    parse(connection.get("users/#{user.nickname}/following"))
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def grab_users_commits(event)
    event.dig(:payload, :commits).select {|com| com.dig(:author, :name) == user.name}
  end

  def compact_shas(events)
    shas = []
    events.each do |event|
      event[:commits].map do |commit|
        unless shas.include?(commit[:sha])
          shas << commit[:sha]
          commit
        end
      end.compact
    end
  end

  def add_token_to_headers
    if user
      connection.headers = {Authorization: "token #{user.token}" }
    else
      connection.headers = {Authorization: "token #{ENV['GITHUB_KEY']}"}
    end
  end
end
