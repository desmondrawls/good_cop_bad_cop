class CopsController < ApplicationController
  def index
    if params[:badge_number] && params[:badge_number] != ""
      @cops = Cop.where(:badge_number => params[:badge_number])
    elsif params[:name] && params[:name] != ""
      @cops = Cop.where("name like ?", "%#{params[:name]}%")
    end
  end
end