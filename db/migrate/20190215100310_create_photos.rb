class CreatePhotos < ActiveRecord::Migration[5.2]
    def change
        create_table :photos do |t|
            t.text :url, null: false
            t.text :caption
            t.text :location
            t.string :long
            t.string :lat
            t.belongs_to :user
            t.timestamps
        end
    end
end
