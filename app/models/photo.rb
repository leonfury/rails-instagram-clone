class Photo < ApplicationRecord
    has_many :likes
    has_many :comments
    belongs_to :user

    mount_uploader :url, UrlUploader
end
