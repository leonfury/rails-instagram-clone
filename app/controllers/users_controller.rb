class UsersController < ApplicationController
    has_many :photos
    has_many :followers
    has_many :comments
end
