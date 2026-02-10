class ReactionsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @post.reactions.find_or_create_by(user: current_user)

    redirect_to @post
  end

  def destroy
    @reaction = Reaction.find(params[:id])
    @post = @reaction.post

    @reaction.destroy if @reaction.user == current_user

    redirect_to @post
  end
end
