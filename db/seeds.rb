# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create(name: 'Luis', birth_date: DateTime.new(1997, 3, 26))
user2 = User.create(name: 'Octavio', birth_date: DateTime.new(1992, 6, 10))

city1 = City.create(name: 'New York')
city2 = City.create(name: 'Mexico')

hotel1 = city1.hotels.create(name: 'Malibu', address: 'Lorem ipsum dolor sit amet.')
hotel2 = city2.hotels.create(name: 'Big Dreams', address: 'Lorem ipsum dolor sit amet.')

room1 = hotel1.rooms.create(description: 'Lorem ipsum dolor sit amet.', image: 'image', price: 200, people_amount: 3, deleted: false)
room2 = hotel2.rooms.create(description: 'Lorem ipsum dolor sit amet.', image: 'image', price: 100, people_amount: 2, deleted: false)

Reservation.create(room_id: room1.id, user_id: user1.id)
Reservation.create(room_id: room2.id, user_id: user1.id)
Reservation.create(room_id: room1.id, user_id: user2.id)