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

  def following # argument as hash
    parse(connection.get("users/#{user.nickname}/following"))
  end

  def followers
    byebug
    parse(connection.get("users/#{user.nickname}/followers"))
  end

  def number_starred_repos
    parse(connection.get("users/#{user.nickname}/starred")).count
  end

  def organizations
    parse(connection.get("users/#{user.nickname}/orgs"))
  end

  def commit_info
    parse(connection.get("users/#{user.nickname}/events")).map do |event|
      if event[:type] == "PushEvent"
        [{repo: event[:repo]}, event.dig(:payload, :commits).select {|com| com.dig(:author, :name) == user.name}]
      end
    end.compact
  end

  # def followers_commit_info
  #   follower_names = followers.map {|follower| follower[:login]}
  #   parse(connection.get("users/#{user.nickname}/events")).select do |event|
  #     if event[:type] == "PushEvent"
  #     event[:type] == "PushEvent" && event.dig(:payload, :commits).any? {|com| com.dig(:author, :name) == user.name}
  #     end
  #   end
  # end

  def repos
    parse(connection.get("users/#{user.nickname}/repos"))
  end

  def contributions_in_last_year
    page = Nokogiri::HTML(open("http://github.com/#{user.nickname}"))
    page.xpath('//*[@id="contributions-calendar"]/div[3]/span[2]').text
  end

  def longest_streak
    page = Nokogiri::HTML(open("http://github.com/#{user.nickname}"))
    page.xpath('//*[@id="contributions-calendar"]/div[4]/span[2]').text
  end

  def current_streak
    page = Nokogiri::HTML(open("http://github.com/#{user.nickname}"))
    page.xpath('//*[@id="contributions-calendar"]/div[5]/span[2]').text
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def add_token_to_headers
    if user
      connection.headers = {Authorization: "token #{user.token}" }
    else
      connection.headers = {Authorization: "token #{ENV['GITHUB_KEY']}"}
    end
  end
end
