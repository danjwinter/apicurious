require 'spec_helper'

RSpec.describe Organization, :type => :model do
  it "can respond to calls for its attributes" do
    org = Organization.new({"name" => "Bluth Corp",
                            "url" => "https://github.com/bluthcorp"})

    expect(org.name).to eq "Bluth Corp"
    expect(org.url).to eq "https://github.com/bluthcorp"
  end
end
