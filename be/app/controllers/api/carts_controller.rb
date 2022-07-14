module Api
  class CartsController < ::ApplicationController
    before_action :authorized
    
    def index
      cart_price = 0
      user_cart = current_user.carts
      user_cart.map do |cart|
        cart_price += cart.product.price * cart.quantity
      end
      render json: ::Dto::BaseResponse.ok(
        data: {
          cart: user_cart.sort_by(&:created_at).reverse.as_json(include: :product),
          total_price: cart_price
        },
      )
    end

    def add_item
      product = Product.find_by(id: params[:product_id])
      unless product.present?
        return render json: ::Dto::BaseResponse.bad_request(
          message: 'Product not found'
        )
      end
      item = current_user.carts.find_or_initialize_by(product_id: product.id)
      if item.persisted?
        item.quantity += 1
        item.save
      else
        item.quantity = 1
        item.save
      end
      index
    end

    def deduct_item
      cart = current_user.carts
      item = cart.find_by(product_id: params[:product_id])
      unless item.present?
        return render json: ::Dto::BaseResponse.bad_request(
          message: 'Product not found in cart'
        )
      end
      if item.quantity > 1
        item.quantity -= 1
        item.save
      else
        item.destroy
      end
      index
    end

    def checkout
      cart = current_user.carts
      cart.each do |item|
        item.destroy
      end
      index
    end
  end
end