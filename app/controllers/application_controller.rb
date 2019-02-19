class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :signed_in?
    helper_method :is_admin?

    def current_user
        if session[:user_id]
            @current_user = User.find(session[:user_id])
        else
            flash[:error] = "User Not Logged In!"
            @current_user = nil
        end
    end

    def signed_in?
        session[:user_id] ? true : false
    end

    def is_admin?
        current_user.role ? true : false
    end

end

