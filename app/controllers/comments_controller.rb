class CommentsController < ApplicationController
  def create
    @cop = Cop.find(params[:cop_id])
    @comment = @cop.comments.build(comment_params)
    if @comment.save
      redirect_to @cop
    else
      flash[:error] = "There was an error saving your comment"
      redirect_to @cop
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :text, :author)
  end
end