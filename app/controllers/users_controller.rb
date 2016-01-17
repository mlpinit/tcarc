class UsersController < ApplicationController
  
  attr_reader :user
  helper_method :user

  def new
    @user = User.new
  end

  def create
    @user = User.new(permitted_user_params)
    if user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def permitted_user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end


end
