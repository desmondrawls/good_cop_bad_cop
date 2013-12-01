class CopsController < ApplicationController
  def index
    @cops = Cop.find_by_badge_or_name(params[:badge_number], params[:name])
  end

  def show
    @cop = Cop.find(params[:id])
    @approval_rating = @cop.approval_rating
    @comments = @cop.comments
  end

  def update
    @cop = Cop.find(params[:id])
    @cop.send(params[:rating])
    if @cop.save
      redirect_to @cop
    else
      flash[:error] = "Unable to save rating"
      redirect_to @cop
    end
  end

end