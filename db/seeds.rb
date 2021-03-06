require 'faker'

Like.delete_all
Comment.delete_all
Photo.delete_all
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:likes);
ActiveRecord::Base.connection.reset_pk_sequence!(:comments);
ActiveRecord::Base.connection.reset_pk_sequence!(:photos);
ActiveRecord::Base.connection.reset_pk_sequence!(:users);

=begin
# clear user avatar directory
dir_path = "public/uploads/user/avatar/*"
Dir.glob(dir_path).each do |d|
    fn = File.join(d, "*")
    Dir.glob(fn).each do |f|
        File.delete(f)
	end
end

# clear photo url directory
dir_path = "public/uploads/photo/url/*"
Dir.glob(dir_path).each do |d|
    fn = File.join(d, "*")
    Dir.glob(fn).each do |f|
	    p f
        File.delete(f)
	end
end
=end

User.create(
    email: "admin@mail.com",
    password: "123",
    username: "admin",
    description: "I am admin",
    role: true,
    address: "admin",
    long: "0",
    lat: "0",
)

i = 0
30.times do  
    user = User.new(
        email: "user#{i}@mail.com",
        password: "123",
        username: Faker::FunnyName.name,
        description: Faker::GreekPhilosophers.quote,
        address: Faker::Address.street_address,
        long: "#{rand(-330..330.99999)}",
        lat: "#{rand(-60..60.99999)}",
        avatar: open(Dir.glob("db/seeds/images/*").sample),
    )
    i += 1
    p "#{user.username} created successfully" if user.save
end

i = 0
80.times do 
    photo = Photo.new(
        url: open(Dir.glob("db/seeds/images/*").sample),
        caption: Faker::TvShows::GameOfThrones.quote,
        user_id: rand(2..30),
        tags: [],
        location: Faker::Address.city,
        long: "#{rand(-330..330.99999)}",
        lat: "#{rand(-60..60.99999)}",
    )

    tag_ar = ['cat', 'cute', 'dog', 'puppy', 'adorable', 'scenery', 'nature', 'quiet', 'colorful', 'beach']
    rand(1..5).times {
        photo.tags << tag_ar.sample
    }

    i += 1
    p "#{photo.caption} created successfully" if photo.save
end

i = 0
200.times do
    comment = Comment.new(
        comment: Faker::TvShows::GameOfThrones.quote,
        user_id: rand(2..30),
        photo_id: rand(1..80),
    )
    i += 1
    p "Comment ##{i} created successfully" if comment.save
end

i = 0
150.times do
    like = Like.new(
        user_id: rand(2..30),
        photo_id: rand(1..80),
    )
    i += 1
    p "Like ##{i} created successfully" if like.save
end
