require 'spec_helper'
require 'ruby-debug'

describe CopsController do 

  describe "#index" do
    before do 
      @cop = FactoryGirl.create(:cop)
    end

    context "with params[:search][:badge_number]" do
      it "should return an array of cops with that badge number - assuming only one" do
        get :index, :search => {:badge_number => @cop.badge_number, :name => ""}
        assigns[:cops].should == [ @cop ]
      end
    end

    context "with params[:search][:name]" do
      it "should return an array of cops with that name" do
        get :index, :search => {:badge_number => "", :name => @cop.name}
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
    let(:cop) { create(:cop, :name => "John McClane", :approves => 0) }

    it "should increment a cop's approval rating" do
      expect{
        put :update, {id: cop.id, rating: "approval", :format => 'js'} 
      }.to change { cop.reload.approves }.by(1)
      response.should be_success
      response.status.should == 200
      response.should render_template("update")
    end

    it "should increment a cop's disapproval rating" do
      expect{
        put :update, {id: cop.id, rating: "disapproval", :format => 'js'} 
      }.to change { cop.reload.disapproves }.by(1)
      response.should be_success
      response.status.should == 200
      response.should render_template("update")
    end
  end

  describe "GET #new" do

    it "assigns a new cop to @cop" do
      get :new
      expect(assigns(:cop)).to be_a_new(Cop)
    end

    it "renders the cops/new template" do
      get :new
      expect(response).to render_template :new
    end
  end

end