require 'spec_helper'
require 'ruby-debug'

describe CopsController do
  let!(:cop) { create(:cop) } 

  describe "#index" do

    shared_examples "best and worst" do |search_params|
      let!(:good_cop) { create(:good_cop) }
      let!(:neutral_cop) { create(:neutral_cop) }
      let!(:bad_cop) { create(:bad_cop) }

      it "assigns a best and worst cop" do
        get :index, :search => search_params
        expect(assigns[:best_cop]).to eq(good_cop)
        expect(assigns[:worst_cop]).to eq(bad_cop)
      end
    end

    context "with params[:search][:badge_number]" do
      #When I use "let!" the search_params variable is undefined. I'm not sure why.
      before do
        @search_params = {:badge_number => cop.badge_number, :name => ""}
      end

      it_behaves_like "best and worst", @search_params

      it "should return an array of cops with that badge number - assuming only one" do
        get :index, :search => @search_params
        assigns[:cops].should == [ cop ]
      end
    end

    context "with params[:search][:name]" do
      before do
        @search_params = {:badge_number => cop.badge_number, :name => ""}
      end

      it_behaves_like "best and worst", @search_params

      it "should return an array of cops with that name" do
        get :index, :search => {:badge_number => "", :name => cop.name}
        assigns[:cops].should == [ cop ]
      end
    end

    context "without params" do
      before do
        @search_params = nil
      end

      it_behaves_like "best and worst", @search_params

      it "should not build an array of cops" do
        get :index
        assigns[:cops].should == nil
      end
    end
  end

  describe "#show" do

    it "should return a cop" do
      get :show, id: cop.id
      expect(assigns[:cop]).to eq(cop)
    end

    it "should return an array of comments" do
      get :show, id: cop.id
      expect(assigns[:comments]).to eq(cop.comments)
    end
  end

  describe "#update" do

    it "should increment a cop's approval rating" do
      expect{
        put :update, {id: cop.id, rating: "approval", :format => 'js'} 
      }.to change { cop.reload.approves }.by(1)
      expect(response).to be_success
      expect(response).to render_template("update")
    end

    it "should increment a cop's disapproval rating" do
      expect{
        put :update, {id: cop.id, rating: "disapproval", :format => 'js'} 
      }.to change { cop.reload.disapproves }.by(1)
      expect(response).to be_success
      expect(response).to render_template("update")
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
      end
    end

    context "with invalid params" do
      it "does not create a new cop without a badge_number" do
        expect {
          post :create, params_without_badge_number
        }.to_not change{Cop.count}
        expect(response).to be_success
        expect(response).to render_template('new')
      end

      it "returns errors"
    end

  end

end