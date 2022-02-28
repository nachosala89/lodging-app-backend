require 'swagger_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
User.create!(name: 'Luis', birth_date: DateTime.new(1997, 3, 26))
valid_auth_obj = AuthenticateUser.new('Luis')
token = valid_auth_obj.call

describe 'Rooms API' do
  let(:Authorization) { "Bearer #{token}" }
  let!(:city) { City.create(name: 'New York') }
  let!(:hotel) { city.hotels.create(name: 'Malibu', address: 'Lorem ipsum dolor sit amet.') }
  path '/rooms' do
    get 'Rooms list' do
      tags 'Room'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'Fetch rooms list' do
        let!(:room) do
          hotel.rooms.create(description: 'Lorem ipsum dolor sit amet.', image: 'image', price: 200, people_amount: 3,
                             deleted: false)
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.size).to eq 1
        end
      end
    end

    post 'Creates a room' do
      tags 'Room'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :room, in: :body, schema: { '$ref' => '#/components/schemas/Room' }
      security [bearer_auth: []]

      response '200', 'Room created' do
        let!(:room) do
          { description: 'Lorem ipsum dolor sit amet.', image: 'image', price: 200, people_amount: 3,
            hotel_id: hotel.id }
        end

        run_test!
      end
    end
  end

  path '/rooms/{room_id}' do
    get 'Room info' do
      produces 'application/json'
      parameter name: :room_id, in: :path, type: :string
      security [bearer_auth: []]

      response '200', 'Fetch room info' do
        let!(:room) do
          hotel.rooms.create(description: 'Lorem ipsum dolor sit amet.', image: 'image', price: 200, people_amount: 3,
                             deleted: false)
        end
        let(:room_id) { room.id }
        run_test!
      end
    end

    delete 'Delete room' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :room_id, in: :path, type: :string
      security [bearer_auth: []]

      response '200', 'Room deleted' do
        let!(:room) do
          hotel.rooms.create(description: 'Lorem ipsum dolor sit amet.',
                             image: 'image', price: 200, people_amount: 3, deleted: false)
        end
        let(:room_id) { room.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['success']).to eq 'The room was deleted succesfully'
        end
      end
    end
  end
end
