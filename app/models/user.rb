class User < ApplicationRecord
    has_secure_password
    has_many :comments
    has_many :likes
    has_many :photos
    mount_uploader :avatar, AvatarUploader

    def self.destroy_cascade(user)
        Like.where(user_id: user.id).delete_all
        Comment.where(user_id: user.id).delete_all
        Photo.where(user_id: user.id).delete_all
        destroy_user(user)
    end

    def self.destroy_user(user)
        return user.destroy ? true : false
    end
end
