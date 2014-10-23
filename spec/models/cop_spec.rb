require 'spec_helper'

describe Cop do
  describe 'associations' do
    it { should belong_to(:precinct)}
  end

  describe 'validations' do
    it { should validate_presence_of(:badge_number)}
    it { should validate_numericality_of(:badge_number)}
    it { should validate_uniqueness_of(:badge_number)}
    it { should validate_presence_of(:name)}
  end

  describe "#find_by_badge_or_name" do
    let(:cop) { FactoryGirl.create(:cop) }

    it "returns an array of cops filtered by badge number - expecting only one match" do
      cops = Cop.find_by_badge_or_name({"badge_number" => cop.badge_number})
      expect(cops).to eq([ cop ])
    end

    it "returns an array of cops filtered by name" do
      cops = Cop.find_by_badge_or_name({"name" => cop.name})
      expect(cops).to eq([ cop ])
    end

  end

  describe "#precinct_number" do
    let(:cop) { FactoryGirl.create(:cop) }

    it "returns the number of the precinct the cop belongs to" do
      expect(cop.precinct_number).to eq(70)
    end
  end

  describe "#approval_rating" do
    let(:good_cop) { FactoryGirl.create(:good_cop)}

    it "returns the fraction of ratings that are approvals" do
      expect(good_cop.approval_rating).to eq(0.75)
    end
  end

  describe "#approval" do
    let(:cop) { FactoryGirl.create(:cop) }

    it "increments a cop's approves" do
      cop.approval
      expect(cop.approves).to eq(1)
    end
  end

  describe "#disapproval" do
    let(:cop) { FactoryGirl.create(:cop) }

    it "increments a cop's disapproves" do
      cop.disapproval
      expect(cop.disapproves).to eq(1)
    end
  end

  describe "#precinct_attributes=" do
    let(:cop) { FactoryGirl.create(:homeless_cop) }
    let(:attributes_for_existing_precinct) { {:number => attributes_for(:precinct)[:number]} }
    let(:attributes_for_new_precinct) { {:number => 111} }

    context "with an existing precinct" do
      it "associates the cop to the existing precinct" do
        @precinct = FactoryGirl.create(:precinct)
        expect {
          cop.precinct_attributes=(attributes_for_existing_precinct)
        }.to_not change{Precinct.count}
        expect(cop.precinct).to eq(@precinct)
      end
    end

    context "with a new precinct" do
      it "associates the cop to a new precinct" do
        expect {
          cop.precinct_attributes=(attributes_for_new_precinct)
        }.to change{Precinct.count}.by(1)
        expect(cop.precinct_number).to eq(111)
      end
    end
  end

  describe "#cpr_rating", :focus => true do
    let(:cop) { create(:cop) }
    let(:rating) { create(:rating) }
    let(:good_rating) { create(:good_rating) }
    let(:bad_rating) { create(:bad_rating) }
    let(:partial_rating) { create(:partial_rating)}

    before do
      @good_rating = create(:good_rating)
      cop.ratings << [rating, good_rating, bad_rating, partial_rating]
    end

    it "returns a hash" do
      expect(cop.cpr_rating.class).to eq(Hash)
    end

    it "calls Rating#averages" do
      expect(cop.ratings).to receive(:rounded_averages)
      cop.cpr_rating
    end

    it "averages each rating" do
      expect(cop.cpr_rating[:courtesy]).to eq((8/3.0).round(1))
      expect(cop.cpr_rating[:professionalism]).to eq(3.0)
      expect(cop.cpr_rating[:respect]).to eq(3.0)
    end

  end

end