require 'spec_helper'

describe "cops", type: :request do 
  let!(:cop) { FactoryGirl.create(:cop) }
  before do
    visit '/'
  end

  it "finds a cop" do
    fill_in 'zip_code', with: cop.precinct.zip_code
    fill_in 'badge_number', with: cop.badge_number
    click_button 'Search'

    page.should have_content cop.name
  end
end