require 'rails_helper'

RSpec.describe Photo, type: :model do
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
    context 'Photo upload check - field presence' do
        it 'error: url absent' do
            photo = Photo.create(user_id: 1)
            expect(photo).not_to be_valid
        end

        it 'error: user absent' do
            photo = Photo.create(url: @file)
            expect(photo).not_to be_valid
        end

        it 'success: photo uploaded' do
            photo = Photo.create(url: @file, user_id: 1)
            expect(photo).to be_valid
        end
    end


    ##### rspec for association #################
    context 'Photo association check' do
        it 'error: belongs_to like' do
            expect(Photo.reflect_on_association(:likes).macro).not_to eq(:belongs_to)
        end

        it 'success: has many likes' do
            expect(Photo.reflect_on_association(:likes).macro).to eq(:has_many)
        end

        it 'error: belongs_to comment' do
            expect(Photo.reflect_on_association(:comments).macro).not_to eq(:belongs_to)
        end

        it 'success: has many comments' do
            expect(Photo.reflect_on_association(:comments).macro).to eq(:has_many)
        end

        it 'error: has_many user' do
            expect(Photo.reflect_on_association(:user).macro).not_to eq(:has_many)
        end

        it 'success: belongs_to user' do
            expect(Photo.reflect_on_association(:user).macro).to eq(:belongs_to)
        end
    end

    ##### rspec for custom models #################
    context 'Destroy_photo check' do
        it 'success: photo deleted successfully' do
            expect(Photo.destroy_photo(1)).to eq(true)
        end

        it 'error: photo does not exist' do
            expect(Photo.destroy_photo(2)).to eq(false)
        end
    end

    context 'Destroy_cascade check' do
        it 'success: photo deleted successfully' do
            expect(Photo.destroy_cascade(1)).to eq(true)
        end

        it 'error: photo does not exist' do
            expect(Photo.destroy_cascade(2)).to eq(false)
        end
    end

    context 'Photo.create_new check' do
        it 'error: photo creation failed' do
            params = {user_id: 1}
            expect(Photo.create_new(params)).to eq(false)
        end

        it 'success: photo created successfully' do
            params = {url: @file, user_id: 1}
            expect(Photo.create_new(params)).to eq(true)
        end
    end

end
