require 'swagger_helper'

RSpec.describe 'api/categories', type: :request do
  path '/api/categories' do
    get('list all categories') do
      tags 'Categories'
      consumes 'application/json'
      security [ bearerAuth: [] ]
      
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
