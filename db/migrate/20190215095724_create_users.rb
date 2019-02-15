class CreateUsers < ActiveRecord::Migration[5.2]
    def change
        create_table :users do |t|
            t.string :username, null: false
            t.string :email, null: false
            t.string :password, null: false
            t.string :password_digest, null: false
            t.text :description, null: false
            t.boolean :role, default: false
            t.text :address, null: false
            t.string :long, null: false
            t.string :lat, null: false
            t.text :avatar, null: false
            t.timestamps
        end
    end
end
