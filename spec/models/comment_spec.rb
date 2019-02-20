require 'rails_helper'

RSpec.describe Comment, type: :model do
    before :each do
        User.delete_all
        Photo.delete_all
        ActiveRecord::Base.connection.reset_pk_sequence!(:users);
        ActiveRecord::Base.connection.reset_pk_sequence!(:photos);
        
        User.create(email: 'user@mail.com', password: '123', username: 'user', description: 'test', address: 'address', long: '123', lat: '123')
        @file = fixture_file_upload('files/test.jpeg', 'jpeg')
        Photo.create(url: @file, user_id: 1)
    end

    ##### rspec for validations #################
    context 'comment upload check - field presence' do
        it 'error: user absent' do
            comment = Comment.create(photo_id: 1)
            expect(comment).not_to be_valid
        end

        it 'error: photo absent' do
            comment = Comment.create(user_id: 1)
            expect(comment).not_to be_valid
        end

        it 'success: comment uploaded' do
            comment = Comment.create(user_id: 1, photo_id: 1)
            expect(comment).to be_valid
        end
    end

    ##### rspec for association #################
    context 'Comment association check' do
        it 'error: has_many user' do
            expect(Comment.reflect_on_association(:user).macro).not_to eq(:has_many)
        end

        it 'success: belongs_to user' do
            expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)
        end

        it 'error: has_many photo' do
            expect(Comment.reflect_on_association(:photo).macro).not_to eq(:has_many)
        end

        it 'success: belongs_to photo' do
            expect(Comment.reflect_on_association(:photo).macro).to eq(:belongs_to)
        end
    end
end
