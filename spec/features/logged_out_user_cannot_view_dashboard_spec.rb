require "rails_helper"

describe "user logs out" do
  it "they cannot access dashboard"  do
    VCR.use_cassette("session#logout") do

      visit root_path

      click_on "Git Yo Self"
      click_on "Logout"

      visit dashboard_path

      expect(current_path).to eq root_path
    end
  end
end
