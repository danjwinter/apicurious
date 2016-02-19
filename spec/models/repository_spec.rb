require 'spec_helper'

RSpec.describe Repository, :type => :model do
  it "can respond to calls for its attributes" do
    repo = Repository.new("name" => "danjwinter/apicurious",
                          "url" => "https://github.com/danjwinter/apicurious",
                          "forks_count" => 4,
                          "stargazers_count" => 3)

    expect(repo.name).to eq "danjwinter/apicurious"
    expect(repo.url).to eq "https://github.com/danjwinter/apicurious"
    expect(repo.forks_count).to eq 4
    expect(repo.stargazers_count).to eq 3
  end
end
