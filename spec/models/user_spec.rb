require 'rails_helper'

RSpec.describe User, type: :model do
    before :each do
        User.delete_all
        ActiveRecord::Base.connection.reset_pk_sequence!(:users);
        # reference point
        User.create(email: 'user@mail.com', password: '123', username: 'user', description: 'test', address: 'address', long: '123', lat: '123')
    end

    ##### rspec for validations #################
    context 'Sign up check - email format' do
        it 'error: email format incorrect - absent @' do
            user = User.create(email: 'user1mail.com', password: '123', username: 'user1', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).not_to be_valid
        end

        it 'error: email format incorrect - absent .' do
            user = User.create(email: 'user1@mailcom', password: '123', username: 'user1', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).not_to be_valid
        end

        # unique to reference point
        it 'success: user created' do 
            user = User.create(email: 'user1@mail.com', password: '123', username: 'user1', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).to be_valid 
        end        
    end

    context 'Sign up check - usename uniqueness' do
        # similar email to reference point
        it 'error: email already exist' do
            user = User.create(email: 'user@mail.com', password: '123', username: 'user1', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).not_to be_valid
        end

        # similar username to reference point
        it 'error: username already exist' do
            user = User.create(email: 'user1@mail.com', password: '123', username: 'user', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).not_to be_valid
        end

        # unique to reference point
        it 'success: user created' do 
            user = User.create(email: 'user1@example.com', password: '123', username: 'user1', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).to be_valid 
        end        
    end
    
    context 'Sign up check - field presence' do
        it 'error: email absent' do
            user = User.create(email: '', password: '123', username: 'user1', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).not_to be_valid
        end

        it 'error: password absent' do
            user = User.create(email: 'user1@mail.com', password: '', username: 'user1', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).not_to be_valid
        end

        it 'error: username absent' do
            user = User.create(email: 'user1@mail.com', password: '123', username: '', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).not_to be_valid
        end

        it 'error: description absent' do
            user = User.create(email: 'user1@mail.com', password: '123', username: 'user1', description: '', address: 'address', long: '123', lat: '123')
            expect(user).not_to be_valid
        end

        it 'error: address absent' do
            user = User.create(email: 'user1@mail.com', password: '123', username: 'user1', description: 'description', address: '', long: '123', lat: '123')
            expect(user).not_to be_valid
        end

        it 'error: longtitude absent' do
            user = User.create(email: 'user1@mail.com', password: '123', username: 'user1', description: 'description', address: 'address', long: '', lat: '123')
            expect(user).not_to be_valid
        end

        it 'error: latitude absent' do
            user = User.create(email: 'user1@mail.com', password: '123', username: 'user1', description: 'description', address: 'address', long: '123', lat: '')
            expect(user).not_to be_valid
        end

        # unique to reference point
        it 'success: user created' do 
            user = User.create(email: 'user1@mail.com', password: '123', username: 'user1', description: 'test', address: 'address', long: '123', lat: '123')
            expect(user).to be_valid 
        end        
    end

    ##### rspec for association #################
    context 'User association check' do
        it 'error: belongs_to photo' do
            expect(User.reflect_on_association(:photos).macro).not_to eq(:belongs_to)
        end

        it 'success: has many photos' do
            expect(User.reflect_on_association(:photos).macro).to eq(:has_many)
        end

        it 'error: belongs_to comments' do
            expect(User.reflect_on_association(:comments).macro).not_to eq(:belongs_to)
        end

        it 'success: has many comments' do
            expect(User.reflect_on_association(:comments).macro).to eq(:has_many)
        end

        it 'error: belongs_to likes' do
            expect(User.reflect_on_association(:likes).macro).not_to eq(:belongs_to)
        end

        it 'success: has many likes' do
            expect(User.reflect_on_association(:likes).macro).to eq(:has_many)
        end
    end

    ##### rspec for custom models #################
    context 'Destroy_user check' do
        it 'success: user deleted successfully' do
            expect(User.destroy_user(1)).to eq(true)
        end

        it 'error: user does not exist' do
            expect(User.destroy_user(2)).to eq(false)
        end
    end

    context 'Destroy_cascade check' do
        it 'success: user deleted successfully' do
            expect(User.destroy_cascade(1)).to eq(true)
        end

        it 'error: user does not exist' do
            expect(User.destroy_cascade(2)).to eq(false)
        end
    end
end
