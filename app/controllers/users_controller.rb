class UsersController < SessionsController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user, only: [:show, :edit, :update]
    before_action :authorize_admin, only: [:index, :destroy]

    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash["success"] = "Your account has been successfully created."
            sign_in
        else
            flash["error"] = "Fail to create account. Error: #{@user.errors.full_messages}"
            render new_user_path
        end 
    end

    def show
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:success] = 'User was successfully updated.'
            redirect_to user_path
        else
            flash[:error] = 'User updated failed.'
            redirect_to user_path
        end
    end

    def destroy
        Photo.where(user_id: @user.id).delete_all
        Comment.where(user_id: @user.id).delete_all
        Like.where(user_id: @user.id).delete_all
        @user.destroy
        flash[:notice] = "User deleted successfully"
        redirect_to users_path
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def authorize_user
        return if is_admin?
        if current_user.id != params[:id].to_i
            flash["error"] = "You do not have sufficient permission to do this action."
            redirect_to root_path
        end
    end

    def authorize_admin
        if !is_admin?
            flash["error"] = "You do not have sufficient permission to do this action."
            redirect_to root_path
        end
    end

    def user_params
        params.require(:user).permit(
            :email, 
            :password, 
            :password_confirmation,
            :username,
            :description,
            :address,
            :long,
            :lat,
            :avatar,
        )
    end
end
