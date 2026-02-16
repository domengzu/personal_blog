class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post.reactions.find_or_create_by(user: current_user)

    redirect_to @post
  end

  def destroy
    @reaction = Reaction.find(params[:id])
    @post = @reaction.post

    @reaction.destroy if @reaction.user == current_user

    redirect_to @post
  end
  
  private

  def set_post
    @post = Post.friendly.find(params[:post_id])
  end
end
