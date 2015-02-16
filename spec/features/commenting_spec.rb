require 'rails_helper'

feature "adding comments to a users page" do
  before :each do
    sign_up("matt")
    click_button "Sign Out"
    sign_up("john")
    click_button "Sign Out"
    sign_up("paul")
  end

  it "has a comment button on a users profile"
  it "records a comment on a users profile"
  it "adds a delete button for the profile owner"
  it "adds a delete button for the commenter"
  it "hides the delete button from other users"
end

feature "adding comments to goals" do
  before :each do
    sign_up("matt")
    add_goal("learn rails")
    click_button "Sign Out"
    sign_up("john")
    click_button "Sign Out"
    sign_up("paul")
  end

  it "has a comment button on a goal page"
  it "records a comment on a goal page"
  it "adds a delete button for the goal owner"
  it "adds a delete button for the commenter"
  it "hides the delete button from other users"
end
