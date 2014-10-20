require 'spec_helper'

describe Cop, focus: true do
  describe 'associations' do
    it { should belong_to(:precinct)}
  end

  describe 'validations' do
    it { should validate_presence_of(:badge_number)}
    it { should validate_numericality_of(:badge_number)}
    it { should validate_presence_of(:name)}
  end

  describe "#find_by_badge_or_name" do
    let(:cop) { FactoryGirl.create(:cop) }

    it "returns an array of cops filtered by badge number - expecting only one match" do
      cops = Cop.find_by_badge_or_name({"badge_number" => cop.badge_number})
      cops.should == [ cop ]
    end

    it "returns an array of cops filtered by name" do
      cops = Cop.find_by_badge_or_name({"name" => cop.name})
      cops.should == [ cop ]
    end

  end

  describe "#precinct_name" do
    let(:cop) { FactoryGirl.create(:cop) }

    it "returns the name of the precinct the cop belongs to" do
      cop.precinct.name = "Brooklyn 111"
      cop.precinct_name.should == "Brooklyn 111"
    end
  end

  describe "#approval_rating" do
    let(:good_cop) { FactoryGirl.create(:good_cop)}

    it "returns the fraction of ratings that are approvals" do
      good_cop.approval_rating.should == 0.75
    end
  end

  describe "#approval" do
    let(:cop) { FactoryGirl.create(:cop) }

    it "increments a cop's approves" do
      cop.approval
      cop.approves.should == 1
    end
  end

  describe "#disapproval" do
    let(:cop) { FactoryGirl.create(:cop) }

    it "increments a cop's disapproves" do
      cop.disapproval
      cop.disapproves.should == 1
    end
  end
  
end