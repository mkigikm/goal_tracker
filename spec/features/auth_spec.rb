require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up for Goal Tracker"
  end

  feature "signing up a user" do
    before :each do
      visit new_user_url
    end

    it "requires a name" do
      click_on "Sign Up"
      expect(page).to have_content("Name can't be blank")
    end

    it "requires a minimum password length" do
      fill_in "Name", with: "matt"
      fill_in "Password", with: "abcde"
      click_on "Sign Up"
      expect(page).to have_content("Password is too short")
    end

    it "show username on the homepage after signup" do
      fill_in "Name", with: "matt"
      fill_in "Password", with: "password"
      click_on "Sign Up"
      expect(page).to have_content("matt")
    end

    it "requires unique usernames" do
      fill_in "Name", with: "matt"
      fill_in "Password", with: "abcdef"
      click_on "Sign Up"
      click_on "Sign Out"
      visit new_user_url
      fill_in "Name", with: "matt"
      fill_in "Password", with: "abcdef"
      click_on "Sign Up"
      
      expect(page).to have_content("Name has already been taken")
    end
  end

end
