require 'rails_helper'

describe "signup process", type: :feature do
    User.delete_all
    it "sign up" do
        visit '/users/new'
        within("form") do
            fill_in 'user[email]', with: 'test@mail.com'
            fill_in 'user[password]', with: '123'
            fill_in 'user[password_confirmation]', with: '123'
            fill_in 'user[username]', with: 'test'
            fill_in 'user[description]', with: 'description'
            fill_in 'user[address]', with: 'address'
            fill_in 'user[long]', with: '101'
            fill_in 'user[lat]', with: '30'
        end

        click_button 'Create User'
        expect(page).to have_content 'Sign Out'
    end
end

