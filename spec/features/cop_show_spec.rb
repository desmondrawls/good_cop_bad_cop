require 'spec_helper'
require 'ruby-debug'

feature "the cop's profile page", :type => :feature do
	let(:good_cop) { FactoryGirl.create(:good_cop) }
  let(:comment) { Comment.create(:title => "Helpful", :text => "He gave me directions to the hospital.", :author => "Charles Manson") }
  let(:rating) { create(:rating) }

  before do
    good_cop.comments << comment
    good_cop.ratings << rating
    good_cop.save
    visit cop_path(good_cop)
  end

  scenario "comments appear" do
    expect(page).to have_text comment.title
    expect(page).to have_text comment.text
    expect(page).to have_text comment.author
    expect(page).to have_text good_cop.approval_rating
  end

  scenario "CPR rating appears", :focus => true do
    expect(page).to have_text "C: #{good_cop.cpr_rating[:courtesy]}"
    expect(page).to have_text "P: #{good_cop.cpr_rating[:professionalism]}"
    expect(page).to have_text "R: #{good_cop.cpr_rating[:respect]}"
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

  scenario "rating CPR with stars", :focus => true do
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


  def behaves_like_stars
    expect(page).to have_css('input', :count => 5)

    expect(page).to have_css("input[value=\"1\"]")
    expect(page).to have_css("input[value=\"2\"]")
    expect(page).to have_css("input[value=\"3\"]")
    expect(page).to have_css("input[value=\"4\"]")
    expect(page).to have_css("input[value=\"5\"]")
  end

end