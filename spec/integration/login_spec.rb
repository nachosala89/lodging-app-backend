require 'swagger_helper'

describe 'login API' do
  path '/login' do
    post 'log in' do
      tags 'Login'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response '200', 'Authenticate user' do
        let!(:user) { User.create(name: 'Luis', birth_date: DateTime.new(1997, 3, 26)) }
        let(:credentials) { { name: 'Luis' } }
        run_test!
      end

      response '401', 'Invalid credentials' do
        let(:credentials) { { name: 'Luis2' } }
        run_test!
      end
    end
  end
end
