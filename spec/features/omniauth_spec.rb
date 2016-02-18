require "rails_helper"

describe "access dashboard from root" do
  it "can sign user in with github"  do
    VCR.use_cassette("github_service#dashboard") do
      visit root_path
      expect(page).to have_content "Login with Github"

      click_on "Login with Github"

      expect(current_path).to eq(dashboard_path)
      save_and_open_page
      # within(".current-streak") do
      #   expect(page).to have_content "Current Streak 0 days"
      # end
    end
  end
end
