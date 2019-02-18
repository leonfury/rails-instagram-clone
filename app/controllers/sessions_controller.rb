class SessionsController < ApplicationController
    


    def new
    end

    def sign_in
        byebug
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
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
