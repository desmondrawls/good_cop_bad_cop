require 'spec_helper'
require 'ruby-debug'

feature "cops", :type => :feature do
  let(:good_cop) { FactoryGirl.create(:good_cop) }

  before do
    visit '/'
  end

  scenario "finds a cop by badge number" do
    fill_in 'search_badge_number', with: good_cop.badge_number
    click_button 'Search'

    expect(page).to have_text good_cop.name
    expect(page).to have_text good_cop.badge_number
    expect(page).to have_text good_cop.precinct_number
    expect(page).to have_text good_cop.approval_rating

    click_link good_cop.name
    current_path.should == cop_path(good_cop)

    expect(page).to have_text good_cop.name
    expect(page).to have_text good_cop.badge_number
    expect(page).to have_text good_cop.precinct_number
    expect(page).to have_text good_cop.approval_rating
    expect(page).to have_css '.comments'
  end

  scenario "finds a cop by name" do
    fill_in 'search_name', with: good_cop.name
    click_button 'Search'

    expect(page).to have_text good_cop.name
    expect(page).to have_text good_cop.badge_number
  end

  scenario "links to the new_cop_path" do    
    click_link 'New Cop'
    expect(current_path).to eq(new_cop_path)
  end

end