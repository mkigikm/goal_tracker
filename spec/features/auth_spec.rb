require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up for Goal Tracker"
  end

  feature "signing up a user" do
    it "requires a name" do
      visit new_user_url
      click_on "Sign Up"

      expect(page).to have_content("Name can't be blank")
    end

    it "requires a minimum password length" do
      visit new_user_url
      fill_in "Name", with: "matt"
      fill_in "Password", with: "abcde"
      click_on "Sign Up"

      expect(page).to have_content("Password is too short")
    end

    it "show username on the homepage after signup" do
      sign_up("matt")

      expect(page).to have_content("matt")
    end

    it "requires unique usernames" do
      sign_up("matt")
      click_on "Sign Out"
      sign_up("matt")

      expect(page).to have_content("Name has already been taken")
    end

    it "doesn't allow signed in users access to the new user page" do
      sign_up("matt")
      visit new_user_url

      expect(page).to_not have_content "Sign up for Goal Tracker"
    end
  end

  it "has a sign in page" do
    visit new_session_url
    expect(page).to have_content "Sign in"
  end

  feature "signing in as a user" do
    before :each do
      sign_up("matt")
      click_button("Sign Out")
    end

    it "doesn't allow access with the wrong password" do
      visit new_session_url
      fill_in "Name", with: "matt"
      click_button "Sign In"

      expect(page).to have_content "Incorrect Password"
    end

    it "takes the user to the goals page after sign in" do
      visit new_session_url
      sign_in("matt", "abcdef")

      expect(page).to have_content "All Goals"
      expect(page).to have_content "matt"
    end

    it "doesn't allow signed in users to sign in again" do
      visit new_session_url
      sign_in("matt", "abcdef")
      visit new_session_url

      expect(page).to have_content "All Goals"
    end
  end

  feature "signing out" do
    it "begins logged out" do
      visit goals_url

      expect(page).to have_content "Sign in"
    end

    it "takes the user to the sign in page after signing out" do
      sign_up("matt")
      click_button "Sign Out"

      expect(page).to have_content "Sign in"
    end
  end
end
