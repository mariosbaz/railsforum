require 'spec_helper'

describe "Home page" do
    it "should have the content 'RailsForum'" do
      visit root_path
      expect(page).to have_content('RailsForum')
    end
end