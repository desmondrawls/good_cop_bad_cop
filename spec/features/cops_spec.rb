require 'spec_helper'

feature "cops", :type => :feature do
  before do
    @cop = FactoryGirl.create(:cop)
    visit '/'
  end

  scenario "finds a cop by badge number" do
    fill_in 'badge_number', with: @cop.badge_number
    click_button 'Search'

    expect(page).to have_text @cop.name
    expect(page).to have_text @cop.badge_number
    expect(page).to have_text @cop.precinct_name
    expect(page).to have_text @cop.approval_rating

    click_link @cop.name
    current_path.should == cop_path(@cop)

    expect(page).to have_text @cop.name
    expect(page).to have_text @cop.badge_number
    expect(page).to have_text @cop.precinct_name
    expect(page).to have_text @cop.approval_rating
  end

  scenario "finds a cop by name" do
    fill_in 'name', with: @cop.name
    click_button 'Search'

    expect(page).to have_text @cop.name
    expect(page).to have_text @cop.badge_number
  end

end