class CommentsController < ApplicationController
    before_action :authorize_admin, only: [:destroy]

    def create
        @photo = Photo.find(params[:id])
        com = Comment.new(
            comment: params[:comment],
            user_id: current_user.id,
            photo_id: @photo.id
        )

        if com.save
            p "Comment Saved"
        else
            p "Add comment fail!"
        end

        respond_to do |format|
            format.js
        end
    end

    def destroy
        Comment.find(params[:id]).destroy
        redirect_to admin_photos_path
    end
    
    private
    def authorize_admin
        if !is_admin?
            flash["error"] = "You do not have sufficient permission to do this action."
            redirect_to root_path
        end
    end

end
