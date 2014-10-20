class CopsController < ApplicationController

  def new
    @cop = Cop.new
  end

  def create
    @cop = Cop.new(cop_params)

    if @cop.save
      redirect_to @cop, notice: "Cop saved successfuly."
    else
      flash[:error] = "Cop was not saved."
      render "new"
    end
  end

  def index
    @cops = Cop.find_by_badge_or_name(search_params) if params[:search]
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
      respond_to do |format|
        format.html { redirect_to @cop }
        format.js
      end
    else
      flash[:error] = "Unable to save rating"
      redirect_to @cop
    end
  end

  private

  def search_params
    params[:search].reject {|k,v| v.empty? }
  end

  def cop_params
    params.require(:cop).permit(:name, :badge_number, :precinct_attributes => [:number])
  end

end