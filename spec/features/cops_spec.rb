require 'spec_helper'

feature "cops", :type => :feature do 

  scenario "finds a cop by badge number" do
    cop = FactoryGirl.create(:cop)
    visit '/'
    fill_in 'badge_number', with: cop.badge_number
    click_button 'Search'

    expect(page).to have_text cop.name
    expect(page).to have_text cop.badge_number
  end

  scenario "finds a cop by name" do
    cop = FactoryGirl.create(:cop)
    visit '/'
    fill_in 'name', with: cop.name
    click_button 'Search'

    expect(page).to have_text cop.name
    expect(page).to have_text cop.badge_number
  end
end