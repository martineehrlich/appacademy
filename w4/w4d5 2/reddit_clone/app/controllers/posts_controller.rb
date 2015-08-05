class PostsController < ApplicationController
  before_action :require_moderator_or_author, only: [:edit, :update, :destroy]

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to sub_url(@post.subs.first)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to subs_url
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_url(@post.subs.first)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new
    @comments = @post.comments[0...-1]
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def require_moderator_or_author
    post = Post.find(params[:id])
    unless post.moderators.include?(current_user) || current_user.id == post.user_id
      flash[:error] = ["You suck"]
      redirect_to subs_url
    end
  end

end
