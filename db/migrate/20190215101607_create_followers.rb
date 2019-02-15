class CreateFollowers < ActiveRecord::Migration[5.2]
    def change
        create_table :followers do |t|
            t.belongs_to :user
            t.integer :follower_id
            t.timestamps
        end
    end
end
