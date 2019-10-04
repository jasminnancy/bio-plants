class ApplicationController < ActionController::Base
    helper_method :current_user

    ### sets current user to logged in user ###

    def current_user
        if @current_user
            return @current_user
        elsif !session[:user_id].nil? 
            @current_user = User.find_by(id: session[:user_id])
        else
            return nil
        end
    end

    def logged_in?
        !!current_user
    end

    ### makes sure a user is logged in ###

    def authorized
        redirect_to login_path unless logged_in?
    end
end
