class CreateUsers < ActiveRecord::Migration[5.2]
    def change
        create_table :users do |t|
            t.string :email, null: false
            t.string :password_digest
            t.string :username, null: false
            t.text :description, null: false
            t.boolean :role, default: false
            t.text :address, null: false
            t.string :long, null: false
            t.string :lat, null: false
            t.text :avatar
            t.timestamps
        end
        add_index :users, :email, unique: true
    end
end
