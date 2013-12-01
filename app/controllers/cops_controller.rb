class CopsController < ApplicationController
  def index
    @cops = Cop.find_by_badge_or_name(params[:badge_number], params[:name])
  end

  def show
    @cop = Cop.find(params[:id])
    @comments = @cop.comments
  end
end