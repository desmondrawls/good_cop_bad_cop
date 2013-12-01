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
    expect(page).to have_css '.comments'
  end

  scenario "finds a cop by name" do
    fill_in 'name', with: @cop.name
    click_button 'Search'

    expect(page).to have_text @cop.name
    expect(page).to have_text @cop.badge_number
  end

  context "the cop has comments" do
    before do
      @cop.comments.build(:title => "Helpful", :text => "He gave me directions to the hospital.", :author => "Charles Manson")
      @cop.save
      visit cop_path(@cop)
    end

    scenario "the comments are displayed on the cop's profile page" do
      expect(page).to have_text "Helpful"
      expect(page).to have_text "He gave me directions to the hospital."
      expect(page).to have_text "Charles Manson"
    end
  end

end