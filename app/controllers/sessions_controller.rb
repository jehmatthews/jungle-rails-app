class SessionsController < ApplicationController
  def new
  end

  def create
    # if user exists and password entered is correct
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # save user id in cookie
      session[:user_id] = user.id
      redirect_to '/'
    else
      # if login does not work, send back to login form
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end      