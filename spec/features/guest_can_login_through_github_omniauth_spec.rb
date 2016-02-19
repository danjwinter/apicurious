require "rails_helper"

describe "guest can login through github" do
  it "sees dashboard with their github info"  do
    VCR.use_cassette("github_service#dashboard") do
      visit root_path
      expect(page).to have_content "Login with Github"

      click_on "Login with Github"

      user = User.last

      expect(current_path).to eq(dashboard_path)

      within(".user-stats") do
        expect(page).to have_content user.name
        expect(page).to have_content user.nickname
        expect(page).to have_content user.email
        expect(page).to have_content "5 Followers"
        expect(page).to have_content "1 Starred"
        expect(page).to have_content "1 Following"
        expect(page).to have_css("img[src*='#{user.image_url}']")
      end

      within(".contributions") do
        expect(page).to have_content "Contributions in the last year 472 "
      end

      within(".current-streak") do
        expect(page).to have_content "Current Streak 0 days"
      end

      within(".longest-streak") do
        expect(page).to have_content "Longest Streak 12 days"
      end

      within("#repos") do
        expect(page).to have_content "active-record-sinatra"
        expect(page).to have_content "Forks: 0"
        expect(page).to have_content "Stargazers: 0"
      end

      within("#recent-commits") do
        expect(page).to have_content "1 commit to danjwinter/apicurious"
      end

      within("#organizations") do
        expect(page).to have_content "TuringTestOrganization"
      end
    end
  end
end
