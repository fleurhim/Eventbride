# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
Event.destroy_all
Attendance.destroy_all

15.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 5), 
    email: Faker::Name.first_name + "@yopmail.com"
  )
end

5.times do
	Event.create(
	    start_date: Faker::Date.forward(days: 23),
	    duration: [5, 15, 30, 60].sample,
	    title: Faker::Lorem.sentence(word_count: 3),
	    description: Faker::Lorem.sentence(word_count: 5),
	    price: Faker::Number.between(from: 1, to: 1000),
	    location: Faker::Address.city,
	    user_id: rand(User.first.id..User.last.id)
	)
end

15.times do
  Attendance.create(
    user_id: rand(User.first.id..User.last.id),
    event_id: rand(Event.first.id..Event.last.id)
  )
end