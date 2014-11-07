require 'spec_helper'
require 'ruby-debug'

feature "the cop's profile page", :js => true, :type => :feature do
	let(:good_cop) { create(:good_cop) }
  let(:good_comment) { create(:good_comment) }
  let(:rating) { create(:rating) }

  before do
    good_cop.comments << good_comment
    good_cop.ratings << rating
    visit "/backbone/cops#cops/#{good_cop.id}"
  end

  scenario "comments appear" do
    expect(page).to have_text good_comment.title
    expect(page).to have_text good_comment.text
    expect(page).to have_text good_comment.author
    expect(page).to have_text good_cop.approval_rating
  end

  scenario "CPR rating appears" do
    expect(page).to have_text "C: #{good_cop.cpr_rating[:courtesy]}"
    expect(page).to have_text "P: #{good_cop.cpr_rating[:professionalism]}"
    expect(page).to have_text "R: #{good_cop.cpr_rating[:respect]}"
  end

  scenario "rating with an approval" do
    click_on 'Approve'
    within '#cop_approval_rating' do
      expect(page).to have_text 0.8
    end
  end

  scenario "rating with a disapproval" do
    click_on 'Disapprove'
    within '#cop_approval_rating' do
      expect(page).to have_text 0.6
    end
  end

  scenario "rating CPR with stars" do
    within(:css, 'form#new_rating') do
      within(:css, 'ul.cpr-ratings') do
        within(:css, 'li#courtesy') do
          expect(page).to have_content("Courtesy:")
          
          behaves_like_stars
        end
        within(:css, 'li#professionalism') do
          expect(page).to have_content("Professionalism:")
          
          behaves_like_stars
        end
        within(:css, 'li#respect') do
          expect(page).to have_content("Respect:")
          
          behaves_like_stars
        end
      end
      
      expect(page).to have_css("input[type=\"submit\"]")

      expect{ 
        choose("rating_courtesy_1")
        choose("rating_professionalism_1")
        choose("rating_respect_1")
        click_on 'Submit' 
      }.to change{good_cop.ratings.count}.by(1)

      expect{
        choose("rating_courtesy_2")
        click_on 'Submit'
      }.to change{good_cop.ratings.count}.by(1)

      expect{
        choose("rating_professionalism_5")
        click_on 'Submit'
      }.to change{good_cop.ratings.count}.by(1)
    end
  end

  scenario "adding a comment" do
    click_on 'New Comment'
    fill_in 'comment-title', with: "Smelly"
    fill_in 'comment-text', with: "Seriously needs to shower more often."
    fill_in 'comment-author', with: "Billy Bob"
    click_on 'Submit'
    within '.comments' do
      expect(page).to have_text "Smelly"
      expect(page).to have_text "Seriously needs to shower more often"
      expect(page).to have_text "Billy Bob"
    end
  end


  def behaves_like_stars
    expect(page).to have_css('input', :count => 5)

    expect(page).to have_css("input[value=\"1\"]")
    expect(page).to have_css("input[value=\"2\"]")
    expect(page).to have_css("input[value=\"3\"]")
    expect(page).to have_css("input[value=\"4\"]")
    expect(page).to have_css("input[value=\"5\"]")
  end

end