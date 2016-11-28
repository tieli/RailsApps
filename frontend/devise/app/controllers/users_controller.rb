class UsersController < ApplicationController

  def new
    @user = User.new()
  end

  def create
    @user = User.create(user_params)
    if @user.save
      #session[:user_id] = @user.id
      cookies[:auth_token] = @user.auth_token
      redirect_to root_path, notice: "User created successfully!"
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end