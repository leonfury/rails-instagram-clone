require 'faker'

Like.delete_all
Comment.delete_all
Photo.delete_all
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:likes);
ActiveRecord::Base.connection.reset_pk_sequence!(:comments);
ActiveRecord::Base.connection.reset_pk_sequence!(:photos);
ActiveRecord::Base.connection.reset_pk_sequence!(:users);

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
3.times do 
    user = User.new(
        email: "user#{i}@mail.com",
        password: "123",
        username: Faker::FunnyName.name,
        description: Faker::GreekPhilosophers.quote,
        address: Faker::Address.street_address,
        long: rand(0..100),
        lat: rand(0..60),
        avatar = open(Dir.glob("db/seeds/images/*").sample)
    )
    i += 1
    p "#{user.username} created successfully" if user.save
end

