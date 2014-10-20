require 'spec_helper'
require 'ruby-debug'

feature "the new cop page", :type => feature do
  before do
    visit new_cop_path
  end

  scenario "creates a new cop" do
  	expect(page).to have_css('.h2', text: 'Enter a New Cop')

  	context "with a valid badge number" do
  		fill_in 'cop_name', with: "Popeye"
  		fill_in 'cop_badge_number', with: "1234"

  		expect { click_button 'Add' }.to change{User.count}.by(1)
  		
  		expect(current_path).to eq(cop_path(User.count))
  		expect(page).to have_text("Popeye")
  		expect(page).to have_text("1234")
  	end
  end
end