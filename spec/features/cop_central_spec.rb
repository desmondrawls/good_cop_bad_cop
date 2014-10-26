feature "cop central" do
	let!(:good_cop) { create(:good_cop) }
	let!(:bad_cop) { create(:bad_cop) }

	before do
		visit '/backbone/cops'
	end

	scenario "it basically works", :focus => true, :js => true do
		expect(page).to have_text("Cop Central")
	end
end