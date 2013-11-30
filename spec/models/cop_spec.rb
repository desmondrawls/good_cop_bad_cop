require 'spec_helper'

describe Cop do
  describe 'associations' do
    it { should belong_to(:precinct)}
  end

  describe "#find_by_badge_or_name" do
    let(:cop) { FactoryGirl.create(:cop) }

    it "returns an array of cops filtered by badge number - expecting only one match" do
      cops = Cop.find_by_badge_or_name(cop.badge_number, "")
      cops.should == [ cop ]
    end

    it "returns an array of cops filtered by name" do
      cops = Cop.find_by_badge_or_name("", cop.name)
      cops.should == [ cop ]
    end

    it "gives preference to badge_number" do
      cops = Cop.find_by_badge_or_name(cop.badge_number, "not the cop's name")
      cops.should == [ cop ]
    end

    it "returns nil when there is no badge_number or name given" do
      cops = Cop.find_by_badge_or_name(nil, nil)
      cops.should == nil
    end
  end
  
end