module Backbone
	class CopsController < ApplicationController
		respond_to :html, :json

		def index
			@cops = Cop.all
		end

		def show
			@cop = Cop.find(params[:id])
		end

		def create
			puts "PARAMS: #{params.inspect}"
			respond_with(Cop.create(cop_params))
		end

		def update
		  cop = Cop.find(params[:id])
		  cop.update_attributes(cop_params)
		  respond_with(cop)
		end

		private

		def cop_params
			params.require(:cop).permit(:name, :badge_number, :approves, :disapproves, :precinct_attributes => [:number])
		end
	end
end