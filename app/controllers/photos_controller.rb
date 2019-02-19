class PhotosController < ApplicationController
    before_action :set_photo, only: [:show, :destroy]
    before_action :authorize_user, only: [:new, :create]
    before_action :authorize_admin, only: [:index_admin, :destroy]

    def index
        @photos = Photo.all
        @photo = Photo.last
        
        @photos = @photos.joins(:user).where('lower(caption) LIKE ? OR lower(username) LIKE ? OR lower(location) LIKE ?', "%#{params[:caption].downcase}%", "%#{params[:caption].downcase}%", "%#{params[:caption].downcase}%") if params[:caption].present?
        @search = params[:caption] if params[:caption].present?

        @photos = @photos.where("? = ANY (tags)", params[:tags]) if params[:tags].present?
        @search = "tags: #{params[:tags]}" if params[:tags].present?

        @photos = @photos.order("created_at DESC")
    end

    def index_user
        @photos = Photo.where(user_id: params[:id]).order("created_at DESC")
        @photo = Photo.last
        @user = User.find(params[:id])
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
        else
            flash[:error] = "Photo upload failed"
        end
        redirect_to root_path
    end

    def show
        respond_to do |format|
            format.js
        end
    end

    def destroy
        Like.where(photo: @photo).delete_all
        Comment.where(photo: @photo).delete_all
        @photo.destroy
        flash[:notice] = "Photo deleted successfully"
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
