require 'spec_helper'

describe CopsController do 

  describe "#index" do
    context "with params[:badge_number]" do
      it "should return an array of cops with that badge number - assuming only one" do
        cop = FactoryGirl.create(:cop)

        get :index, badge_number: cop.badge_number
        assigns[:cops].should == [ cop ]
      end
    end

    context "with params[:name]" do
      it "should return an array of cops with that name" do
        cop = FactoryGirl.create(:cop)

        get :index, name: cop.name
        assigns[:cops].should == [ cop ]
      end
    end
  end
end