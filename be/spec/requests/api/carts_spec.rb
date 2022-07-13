require 'swagger_helper'

RSpec.describe 'api/carts', type: :request do
  path '/api/carts' do
    get('get all products inside user cart') do
      tags 'Carts'
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

  path '/api/carts/add' do
    post('add item to cart') do
      tags 'Carts'
      consumes 'application/json'
      security [ bearerAuth: [] ]

      parameter name: :cart, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :string },
        },
        required: [ 'product_id' ]
      }
      
      response(200, 'successful') do
        let(:Authorization) { 'Bearer ' + JWT.encode({ user_id: User.first.id }, Rails.application.secrets.secret_key_base.to_s) }
        let(:cart) { { product_id: Product.first.id } }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { 'Bearer 12345' }
        let(:cart) { { product_id: Product.first.id } }
        run_test!
      end

      response(200, 'bad request') do
        let(:Authorization) { 'Bearer ' + JWT.encode({ user_id: User.first.id }, Rails.application.secrets.secret_key_base.to_s) }
        let(:cart) { { product_id: '11111111111' } }
        run_test!
      end
    end

    path '/api/carts/deduct' do
      post('remove item from cart') do
        tags 'Carts'
        consumes 'application/json'
        security [ bearerAuth: [] ]
  
        parameter name: :cart, in: :body, schema: {
          type: :object,
          properties: {
            product_id: { type: :string },
          },
          required: [ 'product_id' ]
        }
        
        response(200, 'successful') do
          let(:Authorization) { 'Bearer ' + JWT.encode({ user_id: User.first.id }, Rails.application.secrets.secret_key_base.to_s) }
          let(:cart) { { product_id: Product.first.id } }
          let(:cart) { { product_id: Product.first.id } }
          run_test!
        end
  
        response(401, 'unauthorized') do
          let(:Authorization) { 'Bearer 12345' }
          let(:cart) { { product_id: Product.first.id } }
          run_test!
        end
  
        response(200, 'bad request') do
          let(:Authorization) { 'Bearer ' + JWT.encode({ user_id: User.first.id }, Rails.application.secrets.secret_key_base.to_s) }
          let(:cart) { { product_id: '11111111111' } }
          run_test!
        end
      end
    end

    path '/api/carts/checkout' do
      delete('add to cart') do
        tags 'Carts'
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

    it 'should add item to carts' do
      product_id = Product.last.id
      post '/api/carts/add',
        params: { product_id: product_id },
        headers: { Authorization: 'Bearer ' + JWT.encode({ user_id: User.first.id }, Rails.application.secrets.secret_key_base.to_s) }
      expect(response).to have_http_status(:success)

      post '/api/carts/add',
        params: { product_id: product_id },
        headers: { Authorization: 'Bearer ' + JWT.encode({ user_id: User.first.id }, Rails.application.secrets.secret_key_base.to_s) }
      expect(JSON.parse(response.body)['data']['cart'].find { |cart| cart['product_id'] == product_id }).to be_present
    end
  end
end
