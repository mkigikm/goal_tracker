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
      click_on "Sign Up"
      fill_in "Name", with: "matt"
      fill_in "Password", with: "abcde"
      expect(page).to have_content("Password must be at least 6 characters")
    end

    it "show username on the homepage after signup" do
      fill_in "Name", with: "matt"
      fill_in "Password", with: "password"
      click_on "Sign Up"
      expect(page).to have_content("matt")
    end

  end

end
