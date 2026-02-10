class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      redirect_to @post, alert: "Failed to create comment."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    redirect_to @comment.post, alert: "You are not authorized to delete this comment." and return unless @comment.user == current_user

    @comment.destroy
    redirect_to @comment.post, notice: "Comment was successfully deleted."
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
