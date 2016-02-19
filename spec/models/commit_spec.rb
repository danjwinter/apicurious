require 'spec_helper'

RSpec.describe Commit, :type => :model do
  it "can respond to calls for its attributes" do
    commit = Commit.new("danjwinter/apicurious",
                        "https://github.com/danjwinter/apicurious/commits?author=danjwinter",
                        1,
                        "2016-02-18T21:11:51Z")

    expect(commit.repo).to eq "danjwinter/apicurious"
    expect(commit.url).to eq "https://github.com/danjwinter/apicurious/commits?author=danjwinter"
    expect(commit.commit_count).to eq 1
    expect(commit.date).to eq "2016-02-18T21:11:51Z"
  end

  it "can show a formatted date" do
    commit = Commit.new("danjwinter/apicurious",
                        "https://github.com/danjwinter/apicurious/commits?author=danjwinter",
                        1,
                        "2016-02-18T21:11:51Z")
                        
    expect(commit.formatted_date).to eq "Feb 18"
  end
end
