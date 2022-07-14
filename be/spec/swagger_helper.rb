# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      components: {
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            in: :header,
            name: 'Authorization'
          }
        },
      },
      paths: {},
      servers: [
        {
          url: '{defaultHost}',
          variables: {
            defaultHost: {
              default: 'http://localhost:3000'
            }
          }
        },
        {
          url: 'https://xen-electronic-backend.herokuapp.com/',
          variables: {
            defaultHost: {
              default: 'https://xen-electronic-backend.herokuapp.com/'
            }
          }
        }
      ],
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
