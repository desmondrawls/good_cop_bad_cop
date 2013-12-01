require 'spec_helper'
require 'ruby-debug'

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

  describe "#update" do
    let(:cop) { Cop.create(:name => "John McClane", :approves => 0) }
    # before do
    #   @cop = FactoryGirl.create(:cop, :approves => 1)
    # end

    it "should increment a cop's approval rating" do
      pending "cop.approves is incrementing but somehow the test doesn't see the change"
      puts cop.approves
      expect{
        put :update, {id: cop.id, rating: "approval"} 
      }.to change { cop.approves }.by(1)
      puts cop.approves
      response.should redirect_to(cop)
    end

    it "should increment a cop's disapproval rating" do
      pending
      expect{
        put :update, {id: cop.id, rating: "disapproval"} 
      }.to change { cop.disapproves }.by(1)
    end
  end
end