class SessionsController < ApplicationController
  before_filter :signed_in_user, only: [:destroy] # см. AplicationController
  
  def new
  end

  def create
  	user=User.find_by_last_name(params[:session][:last_name])
  	if user && user.admin? && user.authenticate(params[:session][:password])
  		sign_in_like_admin(user)
  		redirect_to users_path
  	elsif user && user.authenticate(params[:session][:password])
  		sign_in(user)
  		redirect_to root_path
  	else
  		flash.now[:error] = "Invalid Last name/password combination "
  		render 'new'
  	end  			
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end

  
end