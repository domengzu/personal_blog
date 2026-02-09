class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show;end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      # flash.now[:notice] = "Blog post saved successfully."
      # redirect_to @post
      redirect_to @post, notice: "Blog post saved successfully.", status: :see_other
    else
      # flash.now[:alert] = "There was an error saving the blog post."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize_owner!
  end

  def update
    authorize_owner!
    if @post.update(post_params)
      redirect_to @post, notice: "Blog post updated successfully.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize_owner!
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted.", status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: "Post not found."
  end

  def post_params
    # params.expect(post: [ :title, :body ]) # this is a more concise way to write the strong parameters, but it is not yet widely supported in all versions of Rails
    params.require(:post).permit(:title, :body, :user_id) # currently the best practice
  end

  def authorize_owner!
    return if @post.user == current_user

    redirect_to @post, alert: "You are not authorized to perform this action."
  end
end
