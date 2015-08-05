class UsersController < ApplicationController
  before_action :require_logout, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    @user = current_user
  end
end
