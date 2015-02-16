require 'rails_helper'

feature "adding goals process" do
  before :each do
    sign_up("matt")
  end

  it "has a link to add a new goal" do
    visit goals_url

    expect(page).to have_content("Add Goal")

    click_link "Add Goal"

    expect(page).to have_content("Track a New Goal")
  end

  feature "adding a goal" do
    it "validates goals and displays error messages" do
      visit new_goal_url
      click_button "Create Goal"

      expect(page).to have_content("Title can't be blank")
    end

    it "adds a goal to the users list" do
      visit new_goal_url
      fill_in "Title", with: "learn rails"
      choose "Public"
      click_button "Create Goal"

      expect(page).to have_content("learn rails")
    end

    it "displays public goals to all users"
    it "hides private goals from other users"
  end
end
