module Backbone
	class CopsController < ApplicationController

		def index
			@cops = Cop.all
		end

	end
end