# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example User",
             prefecture: "神奈川県",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
    name=Faker::Name.name
    prefecture="神奈川県"
    password="password"
    User.create!(name: name,
                 prefecture: prefecture,
                 password: password,
                 password_confirmation: password)
end
             
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content) }
end
