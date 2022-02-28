require 'swagger_helper'
require 'database_cleaner/active_record'

describe 'cities API' do
  path '/cities' do
    get 'Cities list' do
      tags 'City'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
      User.create!(name: 'Luis', birth_date: DateTime.new(1997, 3, 26))
      valid_auth_obj = AuthenticateUser.new('Luis')
      token = valid_auth_obj.call

      response '200', 'Fetch cities list' do
        let(:Authorization) { "Bearer #{token}" }
        let!(:city1) { City.create(name: 'New York') }
        let!(:city2) { City.create(name: 'Mexico') }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.size).to eq 2
        end
      end
    end
  end
end
