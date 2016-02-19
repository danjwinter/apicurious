class Commit
  attr_accessor :repo, :commit_count, :url, :date

  def initialize(repo, url, commit_count, date)
    @repo = repo
    @url = url
    @commit_count = commit_count
    @date = date
  end

  def formatted_date
    d = date.split("T")[0]
    segmented = d.split("-")
    date_object = DateTime.new(segmented[0].to_i, segmented[1].to_i, segmented[2].to_i)
    date_object.strftime("%b %d")
  end
end
