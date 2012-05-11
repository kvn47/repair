class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:session][:username],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = t(:invalid_signin)
      render 'new'
    else
      sign_in user
      redirect_to root_path
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
