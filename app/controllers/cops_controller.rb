class CopsController < ApplicationController
  def index
    @cops = Cop.where(:badge_number => params[:badge_number])
  end
end