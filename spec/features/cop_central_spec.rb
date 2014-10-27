feature "cop central" do
	let!(:good_cop) { create(:good_cop) }
	let!(:bad_cop) { create(:bad_cop) }
	let!(:good_comment) { create(:good_comment, cop: good_cop)}

	before do
		visit '/backbone/cops'
	end

	scenario "displays a list of cops", :focus => true, :js => true do
		expect(page).to have_text(good_cop.name)
		expect(page).to have_text(good_cop.badge_number)
		expect(page).to have_text(bad_cop.name)
		expect(page).to have_text(bad_cop.badge_number)
	end

	scenario "it links to each cop's show page", :focus => true, :js => true do
		click_on good_cop.name
		expect(page).to have_css('h2', text: good_cop.name)
    expect(page).to have_text good_cop.badge_number
    expect(page).to have_text good_cop.approval_rating
    expect(page).to have_text good_cop.precinct_number
    expect(page).to have_css('section.comments')
    within(:css, 'section.comments') do
    	expect(page).to have_text good_comment.title
    	expect(page).to have_text good_comment.author
    	expect(page).to have_text good_comment.text
    end
	end
end