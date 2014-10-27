module Backbone
	class CopsController < ApplicationController
		respond_to :html, :json

		def index
			@cops = Cop.all
		end

		def show
			@cop = Cop.find(params[:id])
			respond_with(@cop)
		end

	end
end