class PhotosController < ApplicationController
    has_many :likes
    has_many :comments
end
