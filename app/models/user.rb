class User < ApplicationRecord
  has_secure_password
  has_many :comments
  has_many :photos
  mount_uploader :avatar, AvatarUploader
end
