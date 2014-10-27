module Backbone
	class CopsController < ApplicationController

		def index
			@cops = Cop.all
		end

		def show
			@cop = Cop.find(params[:id])
		end

	end
end