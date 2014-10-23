require 'spec_helper'

describe Rating, :focus => true do
  describe "#rounded_averages" do
  	before do
  		create(:rating)
  		create(:good_rating)
  		create(:bad_rating)
  		create(:partial_rating)
  	end

  	it "returns a hash" do
  		expect(Rating.rounded_averages.class).to eq(Hash)
  	end

  	it "calculates averages for each rating category" do
      expect(Rating.rounded_averages[:courtesy]).to eq((8/3.0).round(1))
      expect(Rating.rounded_averages[:professionalism]).to eq(3.0)
      expect(Rating.rounded_averages[:respect]).to eq(3.0)
  	end
  end
end
