require 'spec_helper'

feature "cops", :type => :feature do 

  scenario "finds a cop" do
    cop = FactoryGirl.create(:cop)
    visit '/'
    fill_in 'badge_number', with: cop.badge_number
    click_button 'Search'

    expect(page).to have_text cop.name
  end
end