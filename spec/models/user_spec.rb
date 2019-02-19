require 'rails_helper'

RSpec.describe User, type: :model do
    
        user_params = {email: 'user1@example.com', password: '123', username: 'user1', description: 'user1', address: 'user1', long: '123', lat: '123'}
        user_params_2 = {email: 'user2@example.com', password: '123', username: 'user2', description: 'user2', address: 'user2', long: '123', lat: '123'}
        user = User.create(user_params)
    
    context 'Sign up email' do
        it 'error: email already exist' do
            expect(User.create(user_params)).to_not be_valid 
        end

        it 'success: user created' do
            expect(User.create(user_params_2)).to be_valid 
        end
    end
    
    # context 'sign up with empty fields' do
    #     it 'should have name' do
    #       expect{ User.create!(email: '1@example.com', address: 'test', password: '123') }.to raise_error(ActiveRecord::RecordInvalid)
    #     end
    #     it 'should have email' do
    #       expect{ User.create!(name: 'John Smith', address: 'test', password: '123') }.to raise_error(ActiveRecord::RecordInvalid)
    #     end
    #     it 'should have address' do
    #       expect{ User.create!(name: 'John Smith', email: '1@example.com', password: '123') }.to raise_error(ActiveRecord::RecordInvalid)
    #     end
    
    #     it 'should have password' do
    #       expect{ User.create!(name: 'John Smith', email: '1@example.com') }.to raise_error(ActiveRecord::RecordInvalid)
    #     end
    # end

    # context 'should have default role = user' do
    #     it 'should have role = user' do
    #       user = User.create!(email: 'test@example.com', name: 'John Smith', address: 'test', password: '123')
    #       expect(user.roles).to eq 'user'
    #     end
    # end



end
