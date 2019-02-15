class AddTagsToPhotos < ActiveRecord::Migration[5.2]
    def change
        add_column :photos, :tags, :string, array: true
      end
end
