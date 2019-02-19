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
    # validates :avatar, presence: true

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
