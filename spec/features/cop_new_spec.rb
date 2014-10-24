require 'spec_helper'
require 'ruby-debug'

feature "the new cop page", :type => feature do
	let(:cop) { attributes_for(:cop) }
	let(:precinct) { create(:precinct) }

  before do
   visit new_cop_path
  end

  scenario "creates a new cop with valid inputs" do
  	expect(page).to have_css('h2', text: 'Enter a New Cop')

		fill_in 'cop[name]', with: cop[:name]
		fill_in 'cop[badge_number]', with: cop[:badge_number]
		fill_in 'cop[precinct_attributes][number]', with: precinct.number

		behaves_like_success

		expect(page).to have_content(cop[:name])
		expect(page).to have_content(cop[:badge_number])
		expect(page).to have_content(precinct.number)
  end

  scenario "doesn't create a new precinct if it exists" do
  	fill_in 'cop[name]', with: cop[:name]
		fill_in 'cop[badge_number]', with: cop[:badge_number]
		fill_in 'cop[precinct_attributes][number]', with: precinct.number

		expect { click_button 'Add' }.to_not change{Precinct.count}
	end

  scenario "allows precinct to be blank" do
  	fill_in 'cop[name]', with: cop[:name]
		fill_in 'cop[badge_number]', with: cop[:badge_number]

		behaves_like_success

		expect(page).to have_content(cop[:name])
		expect(page).to have_content(cop[:badge_number])
	end

  scenario "does not create a new cop without a badge_number" do
  	fill_in 'cop[name]', with: cop[:name]

  	behaves_like_failure
  end

  scenario "does not create a new cop with letters in the badge_number field" do
  	fill_in 'cop[name]', with: cop[:name]
  	fill_in 'cop[badge_number]', with: "notanumber"

  	behaves_like_failure
  end

  scenario "does not create a new cop without a name" do
  	fill_in 'cop[badge_number]', with: cop[:badge_number]

  	behaves_like_failure
  end

  scenario "does not create a new cop with a duplicate badge_number" do
  	fill_in 'cop[name]', with: cop[:name]
  	fill_in 'cop[badge_number]', with: cop[:badge_number]
  	click_button 'Add'
  	visit new_cop_path
  	fill_in 'cop[name]', with: "John Mclane"
  	fill_in 'cop[badge_number]', with: cop[:badge_number]

  	behaves_like_failure
  end

  def behaves_like_success
    expect { click_button 'Add' }.to change{Cop.count}.by(1)    
    expect(current_path).to eq(cop_path(Cop.count))
  end

  def behaves_like_failure
    expect { click_button 'Add' }.to_not change{Cop.count}
    expect(page).to have_css('h2', text: 'Enter a New Cop')
    expect(page).to have_content("not saved")
  end
end