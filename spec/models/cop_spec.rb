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
    let(:cop) { create(:cop) }

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
    let(:cop) { create(:cop) }

    it "returns the number of the precinct the cop belongs to" do
      expect(cop.precinct_number).to eq(70)
    end
  end

  describe "#approval_rating" do
    it "returns the fraction of ratings that are approvals" do
      subject.approves, subject.disapproves = 3, 1
      expect(subject.approval_rating).to eq(0.75)
    end

    it "returns 'n/a' when a cop has not yet been rated" do
      expect(subject.approval_rating).to eq("n/a")
    end

    it "returns 1 when there are only approvals" do
      subject.approves = 2
      expect(subject.approval_rating).to eq(1.00)
    end

    it "returns 0 when there are only disapprovals" do
      subject.disapproves = 3
      expect(subject.approval_rating).to eq(0.00)
    end
  end

  describe "#approval" do
    it "increments a cop's approves" do
      subject.approval
      expect(subject.approves).to eq(1)
    end
  end

  describe "#disapproval" do
    it "increments a cop's disapproves" do
      subject.disapproval
      expect(subject.disapproves).to eq(1)
    end
  end

  describe "#precinct_attributes=" do
    let(:cop) { create(:homeless_cop) }
    let!(:precinct) { create(:precinct) }
    let(:attributes_for_existing_precinct) { {:number => precinct.number} }
    let(:attributes_for_new_precinct) { {:number => 111} }

    context "with an existing precinct" do
      it "associates the cop to the existing precinct" do
        expect {
          cop.precinct_attributes=(attributes_for_existing_precinct)
        }.to_not change{Precinct.count}
        expect(cop.precinct).to eq(precinct)
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

  describe "#cpr_rating" do
    let(:cop) { create(:cop) }
    let(:rating) { create(:rating) }
    let(:good_rating) { create(:good_rating) }
    let(:bad_rating) { create(:bad_rating) }
    let(:partial_rating) { create(:partial_rating)}

    before do
      cop.ratings << [rating, good_rating, bad_rating, partial_rating]
    end

    it "returns a hash" do
      expect(cop.cpr_rating).to be_a(Hash)
    end

    it "calls Rating#averages" do
      #Practice with mocks & stubs even though using the real objects would be more thorough.
      ratings = double('ratings')
      allow(cop).to receive(:ratings).and_return(ratings)
      expect(ratings).to receive(:rounded_averages)
      cop.cpr_rating
    end

    it "averages each rating" do
      expect(cop.cpr_rating[:courtesy]).to eq((8/3.0).round(1))
      expect(cop.cpr_rating[:professionalism]).to eq(3.0)
      expect(cop.cpr_rating[:respect]).to eq(3.0)
    end

  end

  describe "best and worst" do
    context "with cops in the database" do
      let!(:good_cop) { create(:good_cop) }
      let!(:neutral_cop) { create(:neutral_cop) }
      let!(:bad_cop) { create(:bad_cop) }

      describe "#best" do
        it "returns the best cop" do
          expect(Cop.best).to eq(good_cop)
        end
      end

      describe "#worst" do
        it "returns the worst cop" do
          expect(Cop.worst).to eq(bad_cop)
        end
      end
    end

    context "without cops in the database" do
      describe "#best" do
        it "returns nil" do
          expect(Cop.best).to eq(nil)
        end
      end

      describe "#worst" do
        it "returns nil" do
          expect(Cop.worst).to eq(nil)
        end
      end
    end
  end
end