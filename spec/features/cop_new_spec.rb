require 'spec_helper'
require 'ruby-debug'

feature "the new cop page", :type => feature do
  before do
    visit new_cop_path
  end

  scenario "creates a new cop with valid inputs" do
  	expect(page).to have_css('h2', text: 'Enter a New Cop')

		fill_in 'cop[name]', with: "Popeye"
		fill_in 'cop[badge_number]', with: "1234"

		expect { click_button 'Add' }.to change{Cop.count}.by(1)
		
		expect(current_path).to eq(cop_path(Cop.count))
		expect(page).to have_content("Popeye")
		expect(page).to have_content("1234")
  end

  scenario "does not create a new cop without a badge_number" do
  	fill_in 'cop[name]', with: "Scorpio"

  	expect { click_button 'Add' }.to_not change{Cop.count}
  	expect(page).to have_css('h2', text: 'Enter a New Cop')
  	expect(page).to have_content("not saved")
  end

  scenario "does not create a new cop with letters in the badge_number field" do
  	fill_in 'cop[name]', with: "Popeye"
  	fill_in 'cop[badge_number]', with: "notanumber"

  	expect { click_button 'Add' }.to_not change{Cop.count}
  	expect(page).to have_css('h2', text: 'Enter a New Cop')
  	expect(page).to have_content("not saved")
  end

  scenario "does not create a new cop without a name" do
  	fill_in 'cop[badge_number]', with: 1234

  	expect { click_button 'Add' }.to_not change{Cop.count}
  	expect(page).to have_css('h2', text: 'Enter a New Cop')
  	expect(page).to have_content("not saved")
  end
end