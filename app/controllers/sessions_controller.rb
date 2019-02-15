class SessionsController < ApplicationController
    
    def new
    end

    def sign_in
        user = User.find_by(email: params[:email])
        
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "Sign In Successful"
        else
            flash[:error] = "Sign In Fail"
        end
        redirect_to root_path
    end

    def sign_out
        session[:user_id] = nil
        redirect_to root_path
    end


end
