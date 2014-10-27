feature "cop central" do
	let!(:good_cop) { create(:good_cop) }
	let!(:bad_cop) { create(:bad_cop) }

	before do
		visit '/backbone/cops'
	end

	scenario "displays a list of cops", :focus => true, :js => true do
		expect(page).to have_text(good_cop.name)
		expect(page).to have_text(good_cop.badge_number)
		expect(page).to have_text(bad_cop.name)
		expect(page).to have_text(bad_cop.badge_number)
	end

	scenario "it links to each cops show page", :focus => true, :js => true do
		click_on good_cop.name
		expect(page).to have_css('h2', text: good_cop.name)
    expect(page).to have_text good_cop.badge_number
    expect(page).to have_css('ul.comments')
	end
end