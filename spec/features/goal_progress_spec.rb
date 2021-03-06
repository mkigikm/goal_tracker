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
      expect(page).to have_content("All Goals")
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

feature "editing goals" do
  before :each do
    sign_up("matt")
    add_goal("learn rails")
  end

  it "shows an edit page" do
    click_link "learn rails"
    click_link "Edit"

    expect(page).to have_content("Edit learn rails")
  end

  it "hides the edit link from other users" do
    click_button "Sign Out"
    sign_up("john")
    click_link "learn rails"

    expect(page).to have_content("learn rails")
    expect(page).to_not have_content("Edit")
  end

  it "validates and displays errors in editing" do
    click_link "learn rails"
    click_link "Edit"
    fill_in "Title", with: ""
    click_button "Edit Goal"

    expect(page).to have_content("Title can't be blank")
  end

  it "edits goal and goes to the goal page" do
    click_link "learn rails"
    click_link "Edit"
    fill_in "Title", with: "learning rails"
    click_button "Edit Goal"

    expect(page).to have_content("learning rails")
    expect(page).to_not have_content("learn rails")
  end
end

feature "deleting goals" do
  before :each do
    sign_up("matt")
    add_goal("learn rails")
  end

  it "shows a delete button on the edit page" do
    click_link "learn rails"
    click_link "Edit"

    expect(page).to have_content("Delete")
  end

  it "removes a deleted goal" do
    click_link "learn rails"
    click_link "Edit"
    click_button "Delete"

    expect(page).to_not have_content("learn rails")
  end
end
