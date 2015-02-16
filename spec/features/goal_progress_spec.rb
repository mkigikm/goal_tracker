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
    it "validates goals and displays error messages"
    it "adds a goal to the users list"
    it "displays public goals to all users"
    it "hides private goals from other users"
  end
end
