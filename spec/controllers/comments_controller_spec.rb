require 'spec_helper'

describe CommentsController do 
  
  describe '#create' do
    let!(:cop) { create(:cop) }
    let(:valid_params) { attributes_for(:comment) }
    let(:params_without_author) { {:title => "Bad Breath", :text => "Keep your distance."} }
    let(:params_without_title) { {:text => "Keep your distance.", :author => "Easy-e"} }
    let(:params_without_text) { {:title => "Bad Breath", :author => "Easy-e"} }

    context "with valid params" do
      it "should create a comment and associate it with a cop" do
        expect{
          post :create, {:comment => valid_params, cop_id: cop.id}
        }.to change { cop.reload.comments.count }.by(1)
        expect(cop.comments.first.title).to eq(valid_params[:title])
        expect(cop.comments.first.text).to eq(valid_params[:text])
        expect(cop.comments.first.author).to eq(valid_params[:author])
      end

      it "should redirect to the cop's show page" do
        post :create, {:comment => valid_params, cop_id: cop.id}
        expect(response).to redirect_to(cop)
      end
    end

    context "with invalid params" do
      it "shouldn't create a comment without an author" do
        expect{
          post :create, {:comment => params_without_author, cop_id: cop.id}
        }.to_not change { cop.reload.comments.count }.by(1)
      end

      it "shouldn't create a comment without a title" do
        expect{
          post :create, {:comment => params_without_title, cop_id: cop.id}
        }.to_not change { cop.reload.comments.count }.by(1)
      end 

      it "shouldn't create a comment without text" do
        expect{
          post :create, {:comment => params_without_text, cop_id: cop.id}
        }.to_not change { cop.reload.comments.count }.by(1)
      end
    end   
  end
  
end