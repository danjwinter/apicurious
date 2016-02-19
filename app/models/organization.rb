class Organization
  attr_reader :name, :url

  def initialize(params)
    @name = params["name"]
    @url = params["url"]
  end
end
