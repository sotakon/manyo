# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
 Task.create!(name: "test#{n}個目", details:"test！#{n}個目", limit: "2021-03-05", stutas: "着手中", priority: "高", user_id: "27")
end

10.times do |n|
  User.create!(name: "test#{n}人目", email: "test#{n}@gmail.com", password: '123456', password_confirmation: '123456',
               admin: false)
end

10.times do |n|
  Label.create!(name: "test#{n}label")
end
