class SessionsController < ApplicationController

    def new
      if current_user
        redirect_to user_path(current_user)
      end
    end
  
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
  
    def logout
      session.clear
      redirect_to login_path
    end
end