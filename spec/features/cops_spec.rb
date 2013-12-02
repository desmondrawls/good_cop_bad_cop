require 'spec_helper'
require 'ruby-debug'

feature "cops", :type => :feature do
  before do
    @good_cop = FactoryGirl.create(:good_cop)
    visit '/'
  end

  scenario "finds a cop by badge number" do
    fill_in 'badge_number', with: @good_cop.badge_number
    click_button 'Search'

    expect(page).to have_text @good_cop.name
    expect(page).to have_text @good_cop.badge_number
    expect(page).to have_text @good_cop.precinct_name
    expect(page).to have_text @good_cop.approval_rating

    click_link @good_cop.name
    current_path.should == cop_path(@good_cop)

    expect(page).to have_text @good_cop.name
    expect(page).to have_text @good_cop.badge_number
    expect(page).to have_text @good_cop.precinct_name
    expect(page).to have_text @good_cop.approval_rating
    expect(page).to have_css '.comments'
  end

  scenario "finds a cop by name" do
    fill_in 'name', with: @good_cop.name
    click_button 'Search'

    expect(page).to have_text @good_cop.name
    expect(page).to have_text @good_cop.badge_number
  end

  context "the cop's profile page" do
    before do
      @comment = Comment.create(:title => "Helpful", :text => "He gave me directions to the hospital.", :author => "Charles Manson")
      @good_cop.comments << @comment
      @good_cop.save
      visit cop_path(@good_cop)
    end

    scenario "comments are displayed on the cop's profile page" do
      expect(page).to have_text @comment.title
      expect(page).to have_text @comment.text
      expect(page).to have_text @comment.author
      expect(page).to have_text @good_cop.approval_rating
    end

    scenario "there are buttons to approve/disapprove" do
      click_on 'Approve'
      within '#approval_rating' do
        expect(page).to have_text @good_cop.reload.approval_rating
      end
      click_on 'Disapprove'
      within '#approval_rating' do
        expect(page).to have_text @good_cop.reload.approval_rating
      end
    end
  end


end