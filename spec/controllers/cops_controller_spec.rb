require 'spec_helper'

describe CopsController do 

  describe "#index" do
    context "with params[:badge_number]" do
      it "should return an array cop with that badge number" do
        cop = FactoryGirl.create(:cop)

        get :index, badge_number: cop.badge_number
        assigns[:cops].should == [ cop ]
      end
    end
  end
end