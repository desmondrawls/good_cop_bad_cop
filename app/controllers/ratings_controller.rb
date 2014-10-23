class RatingsController < ApplicationController
	before_action :load_cop, only: [:create]

	def create
		rating = @cop.ratings.build(rating_params)

		if rating.save
			flash[:notice] = "Your rating was saved."
		else
			flash[:error] = "Unable to save your rating."
		end
		redirect_to cop_path(@cop)
	end

	private

	def load_cop
		@cop = Cop.find(params[:cop_id])
	end

	def rating_params
		params.require(:rating).permit(:courtesy, :professionalism, :respect)
	end

end