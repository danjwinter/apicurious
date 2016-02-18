class UpdateUsers
  include Sidekiq::Worker

  def update
    User.all.each do |user|
      attributes = GithubService.new(user).attributes
      githubdata = GithubData.new(attributes)
      user.update_attribute("githubdata", githubdata)
      user.save
    end
  end
end
