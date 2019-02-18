class PhotosController < ApplicationController

    def index
        @photos = Photo.all
    end

    def index_user
        @photos = Photo.where(user_id: current_user.id)
    end

    def create
        @photo = Photo.new(photo_params)
        @photo.user_id = current_user.id
        if @photo.save
            flash[:success] = "Photo uploaded to gallery succesfully"
        else
            flash[:error] = "Photo upload failed"
        end
        redirect_to my_photos_path
    end

    private
    def photo_params
        params.require(:photo).permit(
            :url, 
            :caption, 
            :location,
            :long,
            :lat,
            :tags,
        )
    end

end
