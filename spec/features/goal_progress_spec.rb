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
      add_goal("learn rails")

      expect(page).to have_content("learn rails")
    end

    it "displays public goals to all users" do
      add_goal("learn rails")
      click_button "Sign Out"
      sign_up("john")
      visit goals_url

      expect(page).to have_content("learn rails")
      expect(page).to have_content("matt")
    end

    it "hides private goals from other users" do
      add_goal("learn rails", false)
      click_button "Sign Out"
      sign_up("john")
      visit goals_url

      expect(page).to_not have_content("learn rails")
    end
  end
end

feature "viewing goals" do
  before :each do
    sign_up("matt")
    add_goal("learn rails")
  end

  it "shows a user their goals" do
    visit goals_url
    click_link "learn rails"

    expect(page).to have_content("Viewing learn rails")
  end

  it "shows public goals to other users" do
    click_button "Sign Out"
    sign_up("john")
    click_link "learn rails"

    expect(page).to have_content("Viewing learn rails for matt")
  end
end
