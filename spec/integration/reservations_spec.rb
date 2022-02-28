require 'swagger_helper'
require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
user = User.create!(name: 'Luis', birth_date: DateTime.new(1997, 3, 26))
valid_auth_obj = AuthenticateUser.new('Luis')
token = valid_auth_obj.call

describe 'Rooms API' do
  let(:Authorization) { "Bearer #{token}" }
  let!(:city) { City.create(name: 'New York') }
  let!(:hotel) { city.hotels.create(name: 'Malibu', address: 'Lorem ipsum dolor sit amet.') }
  let!(:room) do
    hotel.rooms.create(description: 'Lorem ipsum dolor sit amet.', image: 'image', price: 200, people_amount: 3,
                       deleted: false)
  end
  path '/reservations' do
    get 'Reservations list' do
      tags 'Reservation'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'Fetch reservations list' do
        let!(:reservation) do
          Reservation.create(room_id: room.id, user_id: user.id, check_in_date: DateTime.new(2022, 5, 10),
                             check_out_date: DateTime.new(2022, 5, 15))
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.size).to eq 1
        end
      end
    end

    post 'Creates a reservation' do
      tags 'Reservation'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :reservation, in: :body, schema: { '$ref' => '#/components/schemas/Reservation' }
      security [bearer_auth: []]

      response '200', 'Reservation created' do
        let!(:reservation) do
          { room_id: room.id, user_id: user.id, check_in_date: DateTime.new(2022, 5, 10),
            check_out_date: DateTime.new(2022, 5, 15) }
        end

        run_test!
      end
    end
  end

  path '/reservations/{reservation_id}' do
    get 'Room info' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :reservation_id, in: :path, type: :string
      security [bearer_auth: []]

      response '200', 'Fetch reservation info' do
        let!(:reservation) do
          Reservation.create(room_id: room.id, user_id: user.id, check_in_date: DateTime.new(2022, 5, 10),
                             check_out_date: DateTime.new(2022, 5, 15))
        end
        let(:reservation_id) { reservation.id }
        run_test!
      end
    end
  end
end
