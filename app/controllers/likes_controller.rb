class LikesController < ApplicationController
    before_action :authorize_user, only: [:create]
    
    def create
        @photo = Photo.find(params[:id])
        @like = Like.new(
            photo_id: @photo.id,
            user_id: current_user.id
        )
        if @like.save
            p "Photo Liked"
        else
            p "Photo like FAILED"
        end
    end

    private
    def authorize_user
        if !signed_in?
            flash["error"] = "You do not have sufficient permission to do this action."
            redirect_to root_path
        end
    end
end
