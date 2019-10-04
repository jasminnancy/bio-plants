class SessionsController < ApplicationController

  ### redirects if a user is already logged in ###

    def new
      if current_user
        redirect_to user_path(current_user)
      end
    end

  ### creates a new user with a unique username and authenticates password ###
  
    def create
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to users_path
      else 
          flash[:error] = "Username and password combination does not exist"
          render :new
      end
    end

  ### logs a user out before redirecting ###
  
    def logout
      session.destroy
      redirect_to login_path
    end
end