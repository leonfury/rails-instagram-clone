class LikesController < ApplicationController
    
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

end
