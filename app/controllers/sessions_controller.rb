class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email]).authenticate(params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Wrong password/email combination."
      render :new
    end
  end

end
