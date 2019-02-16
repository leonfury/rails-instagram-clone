class PhotosController < ApplicationController


    def index
        @photos = Photo.all
    end

    def index_user
        @photos = Photo.where(user: current_user)
    end

end
