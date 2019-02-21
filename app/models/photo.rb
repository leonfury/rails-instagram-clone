class Photo < ApplicationRecord
    has_many :likes
    has_many :comments
    belongs_to :user
    
    validates :url, presence: true
    validates :user_id, presence: true

    mount_uploader :url, UrlUploader
    paginates_per 50

    def self.destroy_cascade(id)
        Like.where(photo: id).delete_all
        Comment.where(photo: id).delete_all
        destroy_photo(id)
    end

    def self.destroy_photo(id)
        return false if Photo.where(id: id) == []
        return true if Photo.find(id).destroy
    end

    def self.search_all(search)
        result = Photo.all.joins(:user).where('lower(caption) LIKE ? OR lower(username) LIKE ? OR lower(location) LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
        return result, search
    end

    def self.search_tag(tag)
        result = Photo.all.where("? = ANY (tags)", tag)
        return result, "tags: #{tag}"
    end

    def self.create_new(input)
        photo = Photo.new(input)
        p_tags = []

        if input[:tags]
            tags = input[:tags].split(',')
            tags.each do |i|
                p_tags << i.strip
            end
            photo.tags = p_tags
        end
        return photo.save ? true : false
    end

end
