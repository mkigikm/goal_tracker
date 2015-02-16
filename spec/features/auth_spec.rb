require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up for Goal Tracker"
  end

  feature "signing up a user" do

    it "show username on the homepage after signup"

  end

end
