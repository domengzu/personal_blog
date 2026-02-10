class ReactionsController < ApplicationController
  before_action :authenticate_user!
  def create
    post = Post.find(params[:post_id])
    post.reactions.create(user: current_user)
  end

  def destroy
    reaction = Reaction.find(params[:id])
    reaction.destroy if reaction.user == current_user
    redirect_to reaction.post
  end

  # private

  # def reaction_params
  #   params.require(:reaction).permit(:kind)
  # end
end
