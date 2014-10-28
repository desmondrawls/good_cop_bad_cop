require 'spec_helper'
require 'ruby-debug'

feature "the new cop page", :type => feature, :js => true do
	let(:cop) { attributes_for(:cop) }
	let(:precinct) { create(:precinct) }

  before do
   visit '/backbone/cops/#cops/new'
  end

  scenario "creates a new cop with valid inputs", :focus => true do
  	expect(page).to have_css('h2', text: 'Enter a New Cop')

		fill_in 'name', with: cop[:name]
		fill_in 'badge-number', with: cop[:badge_number]
		# fill_in 'precinct_number', with: precinct.number

		behaves_like_success

		expect(page).to have_content(cop[:name])
		expect(page).to have_content(cop[:badge_number])
		# expect(page).to have_content(precinct.number)
  end

  scenario "doesn't create a new precinct if it exists" do
  	fill_in 'name', with: cop[:name]
		fill_in 'badge-number', with: cop[:badge_number]

		expect { click_button 'Add' }.to_not change{Precinct.count}
	end

  scenario "allows precinct to be blank" do
  	fill_in 'name', with: cop[:name]
		fill_in 'badge-number', with: cop[:badge_number]

		behaves_like_success

		expect(page).to have_content(cop[:name])
		expect(page).to have_content(cop[:badge_number])
	end

  scenario "does not create a new cop without a badge_number" do
  	fill_in 'cop[name]', with: cop[:name]

  	behaves_like_failure
  end

  scenario "does not create a new cop with letters in the badge_number field" do
  	fill_in 'name', with: cop[:name]
  	fill_in 'badge-number', with: "notanumber"

  	behaves_like_failure
  end

  scenario "does not create a new cop without a name" do
  	fill_in 'badge-number', with: cop[:badge_number]

  	behaves_like_failure
  end

  scenario "does not create a new cop with a duplicate badge_number" do
  	fill_in 'name', with: cop[:name]
  	fill_in 'badge-number', with: cop[:badge_number]
  	click_button 'Add'
  	visit new_cop_path
  	fill_in 'name', with: "John Mclane"
  	fill_in 'badge-number', with: cop[:badge_number]

  	behaves_like_failure
  end

  def behaves_like_success
    expect { click_button 'Submit' }.to change{Cop.count}.by(1)    
  end

  def behaves_like_failure
    expect { click_button 'Add' }.to_not change{Cop.count}
    expect(page).to have_css('h2', text: 'Enter a New Cop')
    expect(page).to have_content("not saved")
  end
end