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
      redirect_to @post, notice: "Blog post saved successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize_owner!
  end

  def update
    authorize_owner!
    if @post.update(post_params)
      redirect_to @post, notice: "Blog post updated successfuly."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_owner!
    @post.destroy
    redirect_to posts_path, notice: "Blog deleted"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_owner!
    return if @post.user == current_user

    redirect_to @post, alert: "You are not authorized to perform this action."
  end
end
