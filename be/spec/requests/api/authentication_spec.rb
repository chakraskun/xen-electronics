require 'swagger_helper'

RSpec.describe 'api/authentication', type: :request do
  path '/api/auth/login' do
    
    post('login authentication') do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      response(200, 'successful') do
        let(:user) { { email: 'test@gmail.com', password: 'password' } }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:user) { { email: 'test@gmail.com', password: 'wrong_password' } }
        run_test!
      end
    end
  end
end
