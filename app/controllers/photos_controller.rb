class PhotosController < ApplicationController

    def index
        @photos = Photo.all
    end

    def index_user
        @photos = Photo.where(user_id: params[:id])
        @user = User.find(params[:id])
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo = Photo.new(photo_params)
        @photo.user_id = current_user.id
        p_tags = []

        if params[:photo][:tags]
            array = params[:photo][:tags].split(',')
            array.each do |i|
                p_tags << i
            end
            @photo.tags = p_tags
        end

        if @photo.save
            flash[:success] = "Photo uploaded to gallery succesfully"        
        else
            flash[:error] = "Photo upload failed"
        end
        redirect_to root_path
    end

    private
    def photo_params
        params.require(:photo).permit(
            :url, 
            :caption, 
            :location,
            :long,
            :lat,
        )
    end
end
