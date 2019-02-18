class UsersController < SessionsController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user, only: [:show, :edit, :update]
    before_action :authorize_admin, only: [:index, :destroy]

    def index
        @users = User.all
    end

    def show
    end
    
    def new
        @user = User.new
    end

    def edit
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

    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to @user, notice: 'User was successfully updated.' }
                format.json { render :show, status: :ok, location: @user }
            else
                format.html { render :edit }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def authorize_user
        if current_user.id != params[:id].to_i || is_admin?
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
