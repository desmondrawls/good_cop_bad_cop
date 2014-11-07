module Backbone
	class CommentsController < ApplicationController
		before_filter :load_cop
		respond_to :html, :json

		def create
			respond_with(@cop, @cop.comments.create(comment_params))
		end

		private

		def load_cop
			@cop = Cop.find(params[:cop_id])
		end

		def comment_params
			params.require(:comment).permit(:title, :text, :author)
		end
	end
end