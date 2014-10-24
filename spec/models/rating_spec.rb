require 'spec_helper'

describe Rating do
  describe "#rounded_averages" do
		let!(:rating) { create(:rating) }
		let!(:good_rating) { create(:good_rating) }
		let!(:bad_rating) { create(:bad_rating) }
		let!(:partial_rating) { create(:partial_rating) }

  	it "returns a hash" do
  		expect(Rating.rounded_averages).to be_a(Hash)
  	end

  	it "calculates averages for each rating category" do
      expect(Rating.rounded_averages[:courtesy]).to eq((8/3.0).round(1))
      expect(Rating.rounded_averages[:professionalism]).to eq(3.0)
      expect(Rating.rounded_averages[:respect]).to eq(3.0)
  	end
  end
end
