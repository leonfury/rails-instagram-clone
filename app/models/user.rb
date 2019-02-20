class User < ApplicationRecord
    has_secure_password
    has_many :comments
    has_many :likes
    has_many :photos

    validates :email, uniqueness: true, presence: true
    validates :email, format: { with: /.+@.+\...+/, message: "format is incorrect." }
    validates :username, uniqueness: true, presence: true
    validates :description, presence: true
    validates :address, presence: true
    validates :long, presence: true
    validates :lat, presence: true

    mount_uploader :avatar, AvatarUploader

    def self.destroy_cascade(id)
        Like.where(user_id: id).delete_all
        Comment.where(user_id: id).delete_all
        Photo.where(user_id: id).delete_all
        destroy_user(id)
    end

    def self.destroy_user(id)
        return false if User.where(id: id) == []
        return true if User.find(id).destroy
    end
end
