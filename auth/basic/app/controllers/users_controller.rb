class UsersController < ApplicationController

  def new
    @user = User.new()
  end

  def create
    @user = User.create(user_params)
    if @user.save
      #session[:user_id] = @user.id
      cookies[:auth_token] = @user.auth_token
      redirect_to root_path, notice: "Welcome! You have signed up successfully."
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
