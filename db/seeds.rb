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
city3 = City.create(name: 'Phoenix')
city4 = City.create(name: 'Conway')

hotel1 = city1.hotels.create(name: 'Malibu', address: 'Lorem ipsum dolor sit amet.')
hotel1 = city2.hotels.create(name: 'Big Dreams', address: 'Lorem ipsum dolor sit amet.')
hotel2 = city1.hotels.create(name: 'The Breakers', address: 'Lorem ipsum dolor sit amet.')
hotel2 = city2.hotels.create(name: 'Purple Orchid', address: 'Lorem ipsum dolor sit amet.')
hotel3 = city1.hotels.create(name: 'The Manhattan', address: 'Lorem ipsum dolor sit amet.')
hotel4 = city2.hotels.create(name: 'Venture Hotel', address: 'Lorem ipsum dolor sit amet.')
hotel4 = city1.hotels.create(name: 'Hotel Happy springs', address: 'Lorem ipsum dolor sit amet.')
hotel4 = city2.hotels.create(name: 'Cedar Hotel', address: 'Lorem ipsum dolor sit amet.')

room1 = hotel1.rooms.create(description: 'Single room with seaview', image: 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80', price: 200, people_amount: 1)
room2 = hotel2.rooms.create(description: 'Double room with bathroom', image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/sitting-rooms-hilliard-locust-18-11-20-1578948041.jpg', price: 100, people_amount: 2, deleted: false)
hotel4.rooms.create(description: 'Triple room nex to the pool', image: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80', price: 370, people_amount: 3)
hotel4.rooms.create(description: 'Double room with internet', image: 'https://images.unsplash.com/photo-1568495248636-6432b97bd949?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80', price: 150, people_amount: 2)
hotel4.rooms.create(description: 'Triple room with bathroom', image: 'https://images.unsplash.com/photo-1591088398332-8a7791972843?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80', price: 500, people_amount: 3)
hotel4.rooms.create(description: 'Double room', image: 'https://images.unsplash.com/photo-1587985064135-0366536eab42?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80', price: 100, people_amount: 2)

Reservation.create(room_id: room1.id, user_id: user1.id, check_in_date: DateTime.new(2022, 5, 10), check_out_date: DateTime.new(2022, 5, 15))
Reservation.create(room_id: room2.id, user_id: user1.id, check_in_date: DateTime.new(2022, 6, 10), check_out_date: DateTime.new(2022, 6, 15))
Reservation.create(room_id: room1.id, user_id: user2.id, check_in_date: DateTime.new(2022, 7, 10), check_out_date: DateTime.new(2022, 7, 15))