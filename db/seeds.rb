require 'faker'

Like.delete_all
Comment.delete_all
Photo.delete_all
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:likes);
ActiveRecord::Base.connection.reset_pk_sequence!(:comments);
ActiveRecord::Base.connection.reset_pk_sequence!(:photos);
ActiveRecord::Base.connection.reset_pk_sequence!(:users);

# clear user avatar directory
dir_path = "public/uploads/user/avatar/*"
Dir.glob(dir_path).each do |d|
    fn = File.join(d, "*")
    Dir.glob(fn).each do |f|
        File.delete(f)
	end
end

=begin
https://rubyrails-instagram-clone-leon.herokuapp.com/uploads/photo/url/1/tesla-cat.jpg

Dir.glob("public/uploads/user/avatar/*")

Dir.glob("*")

dir_path = "public/uploads/user/avatar/*"
Dir.glob(dir_path).each do |d|
    fn = File.join(d, "*")
    Dir.glob(fn).each do |f|
	    p f
	end
end
=end

# clear photo url directory
dir_path = "public/uploads/photo/url/*"
Dir.glob(dir_path).each do |d|
    fn = File.join(d, "*")
    Dir.glob(fn).each do |f|
	    p f
        File.delete(f)
	end
end

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
5.times do  
    user = User.new(
        email: "user#{i}@mail.com",
        password: "123",
        username: Faker::FunnyName.name,
        description: Faker::GreekPhilosophers.quote,
        address: Faker::Address.street_address,
        long: rand(0..100),
        lat: rand(0..60),
        avatar: open(Dir.glob("db/seeds/images/*").sample),
    )
    i += 1
    p "#{user.username} created successfully" if user.save
end

=begin
i = 0
5.times do 
    photo = Photo.new(
        # url: open(Dir.glob("db/seeds/images/*").sample),
        url: open(Faker::Avatar.image),
        caption: Faker::TvShows::GameOfThrones.quote,
        user_id: rand(2..30),
        tags: [],
    )

    tag_ar = ['cat', 'cute', 'dog', 'puppy', 'adorable']
    rand(1..5).times {
        photo.tags << tag_ar.sample
    }

    i += 1
    p "#{photo.caption} created successfully" if photo.save
end

i = 0
20.times do
    comment = Comment.new(
        comment: Faker::TvShows::GameOfThrones.quote,
        user_id: rand(2..5),
        photo_id: rand(1..5),
    )
    i += 1
    p "Comment ##{i} created successfully" if comment.save
end

i = 0
15.times do
    like = Like.new(
        user_id: rand(2..5),
        photo_id: rand(1..5),
    )
    i += 1
    p "Like ##{i} created successfully" if like.save
end
=end