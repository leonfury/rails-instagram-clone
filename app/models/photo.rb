class Photo < ApplicationRecord
    has_many :likes
    has_many :comments
    belongs_to :user
    mount_uploader :url, UrlUploader

    def self.destroy_cascade(p)
        Like.where(photo: p).delete_all
        Comment.where(photo: p).delete_all
        destroy_photo(p)
    end

    def self.destroy_photo(p)
        return p.destroy ? true : false
    end

    def self.search_all(search)
        result = Photo.all.joins(:user).where('lower(caption) LIKE ? OR lower(username) LIKE ? OR lower(location) LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
        return result, search
    end

    def self.search_tag(tag)
        result = Photo.all.where("? = ANY (tags)", tag)
        return result, "tags: #{tag}"
    end

end
