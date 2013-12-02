require 'spec_helper'

describe CommentsController do 
  let(:cop) { FactoryGirl.create(:cop) }
  describe '#create' do
    it "should create a comment and associate it with a cop" do
      expect{
        post :create, {:comment => {title: "bad breath", text: "keep your distance", author: "eazy-e"}, cop_id: cop.id}
      }.to change { cop.reload.comments.count }.by(1)
      cop.reload.comments.first.title.should == "bad breath"
      response.should redirect_to(cop)
    end
  end
  
end