class SessionsController < ApplicationController
  before_action :require_login!, only: :destroy
  before_action :require_logout, except: :destroy
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])
    if !!@user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(user_params)
      flash.now[:errors] = ["Invalid login info"]
      render 'new'
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end
