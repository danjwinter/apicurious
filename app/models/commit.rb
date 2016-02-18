class Commit
  attr_accessor :repo, :commit_count, :url

  def initialize(repo, url, commit_count)
    @repo = repo
    @url = url
    @commit_count = commit_count
  end
end
