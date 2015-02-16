require 'rails_helper'

feature "adding comments to a users page" do
  let(:comment_body) { "yo dawg, wher u at?" }

  before :each do
    sign_up("matt")
    click_button "Sign Out"
    sign_up("john")
    click_button "Sign Out"
    sign_up("paul")
    visit "users/matt"
  end

  it "has a comment button on a users profile" do
    expect(page).to have_content "Comment"
  end

  feature "leaving comments on a user profile" do
    before :each do
      fill_in "Comment", with: comment_body
      click_button "Comment"
    end

    it "records a comment on a users profile" do
      expect(page).to have_content comment_body
    end

    it "adds a delete button for the commenter" do
      expect(page).to have_content "Delete"
    end

    it "deletes comments" do
      click_button "Delete"

      expect(page).to_not have_content comment_body
    end

    it "adds a delete button for the profile owner" do
      click_button "Sign Out"
      sign_in("matt")
      visit "users/matt"

      expect(page).to have_content "Delete"
    end

    it "hides the delete button from other users" do
      click_button "Sign Out"
      sign_in("john")
      visit "users/matt"

      expect(page).to_not have_content "Delete"
    end
  end
end

feature "adding comments to goals" do
  let(:comment_body) { "yo dawg, wher u at?" }

  before :each do
    sign_up("matt")
    add_goal("learn rails")
    click_button "Sign Out"
    sign_up("john")
    click_button "Sign Out"
    sign_up("paul")
    click_link "learn rails"
  end

  it "has a comment button on a goal page" do
    expect(page).to have_content "Comment"
  end

  feature "leaving comments on a goal" do
    before :each do
      click_link "learn rails"
      fill_in "Comment", with: comment_body
      click_button "Comment"
    end

    it "records a comment on a goal page" do
      expect(page).to have_content comment_body
    end

    it "adds a delete button for the goal owner" do
      expect(page).to have_content "Delete"
    end

    it "adds a delete button for the commenter" do
      click_button "Sign Out"
      sign_in("matt")
      click_link "learn rails"

      expect(page).to have_content "Delete"
    end
    
    it "hides the delete button from other users" do
      click_button "Sign Out"
      sign_in("john")
      click_link "learn rails"

      expect(page).to_not have_content "Delete"
    end
  end
end
