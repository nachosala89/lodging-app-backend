require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1', info: { title: 'Lodgind API V1', version: 'v1' }, basePath: '/api/v1',
      components: {
        securitySchemes: { bearer_auth: { type: :http, scheme: :bearer, bearerFormat: :JWT } },
        schemas: {
          User: { properties: { id: { type: :integer }, name: { type: :string }, birth_date: { type: :datetime } } },
          City: { properties: { id: { type: :integer }, name: { type: :string } } },
          Hotel: { properties: { id: { type: :integer }, name: { type: :string },
                                 address: { type: :string }, city: { '$ref' => '#/components/schemas/City' } } },
          Room: {
            properties: {
              id: { type: :integer }, description: { type: :text }, image: { type: :string }, price: { type: :float },
              people_amount: { type: :integer }, deleted: { type: :boolean },
              hotel: { '$ref' => '#/components/schemas/Hotel' }
            }
          },
          Reservation: {
            properties: {
              id: { type: :integer }, check_in_date: { type: :datetime }, check_out_date: { type: :datetime },
              room: { '$ref' => '#/components/schemas/Room' }, user: { '$ref' => '#/components/schemas/User' }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
