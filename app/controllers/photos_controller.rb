class PhotosController < ApplicationController

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
        @photo = Photo.find(params[:id])
        
        respond_to do |format|
            format.js
        end
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
