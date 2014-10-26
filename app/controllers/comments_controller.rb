class CommentsController < ApplicationController
  def new
    @cop = Cop.find(params[:cop_id])
    @comment = Comment.new
  end

  def create
    @cop = Cop.find(params[:cop_id])
    @comment = @cop.comments.build(comment_params)
    flash[:error] = "We were unable to save your comment." unless @comment.save 
    respond_to do |format|
      format.html { redirect_to @cop}
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :text, :author)
  end
end