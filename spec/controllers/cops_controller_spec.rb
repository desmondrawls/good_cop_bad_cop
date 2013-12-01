require 'spec_helper'

describe CopsController do 

  describe "#index" do
    before do 
      @cop = FactoryGirl.create(:cop)
    end

    context "with params[:badge_number]" do
      it "should return an array of cops with that badge number - assuming only one" do
        get :index, badge_number: @cop.badge_number
        assigns[:cops].should == [ @cop ]
      end
    end

    context "with params[:name]" do
      it "should return an array of cops with that name" do
        get :index, name: @cop.name
        assigns[:cops].should == [ @cop ]
      end
    end

    context "without params" do
      it "should not build an array of cops" do
        get :index
        assigns[:cops].should == nil
      end
    end
  end

  describe "#show" do
    before do
      @cop = FactoryGirl.create(:cop)
    end

    it "should return a cop" do
      get :show, id: @cop.id
      assigns[:cop].should == @cop
    end

    it "should return an array of comments" do
      get :show, id: @cop.id
      assigns[:comments].should == @cop.comments
    end
  end
end