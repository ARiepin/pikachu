class SessionsController < ApplicationController
	def new
	end

	def create
	  user = User.authenticate(params[:email], params[:password])
	  admin = Admin.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id
	    redirect_to user, :notice => "Logged in as #{user.nickname}!"
	  elsif admin
	    session[:admin_id] = admin.id
	    redirect_to users_path, :notice => "Logged in as #{admin.nickname}!"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
	end

	def destroy
	  session[:user_id] = nil
	 	session[:admin_id] = nil
	  redirect_to root_url, :notice => "Logged out!"
	end
end
