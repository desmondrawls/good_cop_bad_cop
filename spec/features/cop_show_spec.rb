require 'spec_helper'
require 'ruby-debug'

feature "the cop's profile page", profile: true, :type => :feature do
	let(:good_cop) { FactoryGirl.create(:good_cop) }
  let(:comment) { Comment.create(:title => "Helpful", :text => "He gave me directions to the hospital.", :author => "Charles Manson") }
  
  before do
    good_cop.comments << comment
    good_cop.save
    visit cop_path(good_cop)
  end

  scenario "comments are displayed on the cop's profile page" do
    expect(page).to have_text comment.title
    expect(page).to have_text comment.text
    expect(page).to have_text comment.author
    expect(page).to have_text good_cop.approval_rating
  end

  scenario "rating with an approval", :js => true do
    click_on 'Approve'
    within '#cop_approval_rating' do
      expect(page).to have_text 0.8
    end
  end

  scenario "rating with a disapproval", :js => true do
    click_on 'Disapprove'
    within '#cop_approval_rating' do
      expect(page).to have_text 0.6
    end
  end

  def behaves_like_stars
    expect(page).to have_css('form input', :count => 5)

    expect(page).to have_css("input[value=\"1\"]")
    expect(page).to have_css("input[value=\"2\"]")
    expect(page).to have_css("input[value=\"3\"]")
    expect(page).to have_css("input[value=\"4\"]")
    expect(page).to have_css("input[value=\"5\"]")
  end

  scenario "rating CPR with stars" do
    within(:css, 'ul.cpr-ratings li#courtesy') do
      expect(page).to have_content("Courtesy:")
      
      behaves_like_stars
    end
    within(:css, 'ul.cpr-ratings li#professionalism') do
      expect(page).to have_content("Professionalism:")
      
      behaves_like_stars
    end
    within(:css, 'ul.cpr-ratings li#respect') do
      expect(page).to have_content("Respect:")
      
      behaves_like_stars
    end
  end

  scenario "adding a comment", :js => true do
    click_on 'New Comment'
    fill_in 'comment_title', with: "Straight Outta Compton"
    fill_in 'comment_text', with: "Be nice to the police!"
    fill_in 'comment_author', with: "NWA"
    click_on 'Done'
    within '.comments' do
      expect(page).to have_text "Straight Outta Compton"
      expect(page).to have_text "Be nice to the police!"
      expect(page).to have_text "NWA"
    end
  end

end