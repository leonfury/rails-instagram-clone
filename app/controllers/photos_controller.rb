class PhotosController < ApplicationController
    before_action :set_photo, only: [:show, :destroy]
    before_action :authorize_user, only: [:new, :create]
    before_action :authorize_admin, only: [:index_admin, :destroy]

    def index
        @photos = Photo.all
        @photo = Photo.last
        
        @photos, @search = Photo.search_all(params[:caption].downcase) if params[:caption].present?
        @photos, @search = Photo.search_tag(params[:tags]) if params[:tags].present?
        
        @photos = @photos.order("created_at DESC")
    end

    def index_user
        @user = User.find(params[:id])
        @photos = Photo.where(user: @user).order("created_at DESC")
        @photo = Photo.last 
    end

    def index_admin
        @photos = Photo.all.order("created_at DESC")
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
                p_tags << i.strip
            end
            @photo.tags = p_tags
        end

        if @photo.save
            flash[:success] = "Photo uploaded to gallery succesfully"        
            redirect_to root_path
        else
            flash[:error] = "Photo upload failed"
            redirect_to new_user_photo_path(current_user.id)
        end
        
    end

    def show
        respond_to do |format|
            format.js
        end
    end

    def destroy
        if Photo.destroy_cascade(@photo)
            flash[:notice] = "Photo deleted successfully."
        else
            flash[:error] = "Photo deletion failed."
        end
        redirect_to admin_photos_path
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

    def set_photo
        @photo = Photo.find(params[:id])
    end

    def authorize_user
        if current_user.id != params[:user_id].to_i
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
end
