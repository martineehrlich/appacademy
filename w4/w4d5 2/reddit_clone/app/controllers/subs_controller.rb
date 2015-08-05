class SubsController < ApplicationController
  before_action :moderator_required, only: [:edit, :update]

  def index
    @subs = Sub.all
  end

  def new
    @sub = current_user.subs.new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render 'new'
    end
  end

  def show
    @subs = Sub.all
    @sub = Sub.find(params[:id])
    @new_post = @sub.posts.new
    @new_post.sub_ids = [@sub.id]
    @posts = @sub.posts[0...-1]
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render 'edit'
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def moderator_required
    sub = Sub.find(params[:id])
    redirect_to sub_url(params[:id]) unless current_user == sub.moderator
  end
end
