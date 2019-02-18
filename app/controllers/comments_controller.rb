class CommentsController < ApplicationController
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
end
