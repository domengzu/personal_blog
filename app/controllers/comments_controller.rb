class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user || current_user.admin?

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      redirect_to @post, alert: "Failed to create comment."
    end
  end

  def edit;end

  def update
    @comment = Comment.find(params[:id])
    unless current_user.admin? || @comment.user == current_user
      redirect_to @comment.post, alert: "You are not authorized to edit this comment." and return
    end

    if @comment.update(comment_params)
      redirect_to @comment.post, notice: "Comment was successfully updated."
    else
      redirect_to @comment.post, alert: "Failed to update comment."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    unless current_user.admin? || @comment.user == current_user
      redirect_to @comment.post, alert: "You are not authorized to delete this comment." and return
    end

    @comment.destroy
    redirect_to @comment.post, notice: "Comment was successfully deleted."
  end

  private

  def set_post
    @post = Post.friendly.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
