require 'swagger_helper'

RSpec.describe 'api/products', type: :request do
  path '/api/products' do
    get('list all products') do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'
      security [ bearerAuth: [] ]

      parameter name: :category_id, in: :query, type: :string, required: false
      
      response(200, 'successful') do
        let(:Authorization) { 'Bearer ' + JWT.encode({ user_id: User.first.id }, Rails.application.secrets.secret_key_base.to_s) }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { 'Bearer 12345' }
        run_test!
      end
    end
  end
end
