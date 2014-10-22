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

  describe "#new" do

    it "assigns a new cop to @cop" do
      get :new
      expect(assigns(:cop)).to be_a_new(Cop)
    end

    it "renders the cops/new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "#create" do
    let(:valid_params) { {:cop => {name: "Popeye", badge_number: 1234}} }
    let(:params_without_badge_number) { {:cop => {name: "Popeye"}}}
    let(:params_without_name) { {:cop => {badge_number: 1234}}} 

    context "with valid params" do
      it "creates a new cop" do
        expect { 
          post :create, valid_params
        }.to change{Cop.count}.by(1)
        expect(response).to redirect_to(cop_path(Cop.count))
        expect(response.status).to eq(302)
      end
    end

    context "with invalid params" do
      it "does not create a new cop without a badge_number" do
        expect {
          post :create, params_without_badge_number
        }.to_not change{Cop.count}
        expect(response).to render_template('new')
        expect(response.status).to eq(200)
      end
    end

  end

end