require 'swagger_helper'

describe 'Signin API' do
  path '/signup' do
    post 'sign up' do
      tags 'Signup'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: { '$ref' => '#/components/schemas/User' }

      response '201', 'Create new user' do
        let(:user) { { name: 'Octavio', birth_date: '2000-01-01' } }
        run_test!
      end

      response '422', 'User name has already been taken' do
        let!(:user1) { User.create(name: 'Luis', birth_date: DateTime.new(1997, 3, 26)) }
        let(:user) { { name: 'Luis', birth_date: '2000-01-01' } }
        run_test!
      end
    end
  end
end
