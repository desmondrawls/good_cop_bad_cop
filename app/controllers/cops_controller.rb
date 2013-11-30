class CopsController < ApplicationController
  def index
    @cops = Cop.find_by_badge_or_name(params[:badge_number], params[:name])
  end
end