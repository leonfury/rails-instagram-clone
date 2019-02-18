class Like < ApplicationRecord
    validates :photo_id, uniqueness: {scope: :user_id}
end
