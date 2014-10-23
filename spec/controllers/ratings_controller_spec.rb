require 'spec_helper'
require 'ruby-debug'

describe RatingsController, :focus => true do
	let(:cop) { create(:cop) }
	let(:valid_params) {attributes_for(:rating)}

	describe "#create" do
		it "creates a rating with valid params" do
			expect {
				post :create, {:cop_id => cop.id, :rating => valid_params}
			}.to change{Rating.count}.by(1)
		end
	end
	
end