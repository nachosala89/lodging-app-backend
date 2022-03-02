require 'swagger_helper'
require 'database_cleaner/active_record'

describe 'Hotels API' do
  path '/cities/{city_id}/hotels' do
    get 'Hotels list' do
      tags 'Hotels'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :city_id, in: :path, type: :string
      security [bearer_auth: []]
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
      User.create!(name: 'Luis', birth_date: DateTime.new(1997, 3, 26))
      valid_auth_obj = AuthenticateUser.new('Luis')
      token = valid_auth_obj.call

      response '200', 'Fetch hotels list' do
        let(:Authorization) { "Bearer #{token}" }
        let!(:city) { City.create(name: 'New York') }
        let!(:city_id) { city.id }
        let!(:hotel1) { city.hotels.create(name: 'Malibu', address: 'Lorem ipsum dolor sit amet.') }
        let!(:hotel2) { city.hotels.create(name: 'Big Dreams', address: 'Lorem ipsum dolor sit amet.') }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.size).to eq 2
        end
      end
    end
  end
end
