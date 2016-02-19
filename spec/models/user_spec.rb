require 'spec_helper'

RSpec.describe User, :type => :model do
  it "can respond to calls for its attributes" do
    user = User.create(uid: "13614117",
                       provider: "github",
                       token: "457b2b5f768d7e09b42463635bc4bd1929d4c2f5",
                       nickname: "danjwinter",
                       email: "dan.j.winter@gmail.com",
                       name: "Dan Winter",
                       image_url: "https://avatars.githubusercontent.com/u/13614117?v=3")

    expect(user.uid).to eq "13614117"
    expect(user.provider).to eq "github"
    expect(user.token).to eq "457b2b5f768d7e09b42463635bc4bd1929d4c2f5"
    expect(user.nickname).to eq "danjwinter"
    expect(user.email).to eq "dan.j.winter@gmail.com"
    expect(user.name).to eq "Dan Winter"
    expect(user.image_url).to eq "https://avatars.githubusercontent.com/u/13614117?v=3"
  end
end
