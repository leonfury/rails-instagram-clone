class User < ApplicationRecord
  has_secure_password
  has_many :comments
  mount_uploader :avatar, AvatarUploader
end
