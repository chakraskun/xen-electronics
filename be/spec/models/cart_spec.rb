require 'rails_helper'

RSpec.describe Cart, type: :model do
  user = User.first
  category = Category.find_or_create_by(name: 'electronics', image_url: 'some_url')
  product = Product.find_or_create_by(
    name: 'playstation',
    description: 'some_description',
    price_cents: 500,
    image_url: 'some_url',
    stock: 10,
    category_id: category.id
  )

  it 'has a valid user' do
    new_cart = Cart.new(
      user_id: 'aaaaaaaaa',
      product_id: product.id
    )
    expect(new_cart).to_not be_valid
    new_cart.user_id = user.id
    expect(new_cart).to be_valid
  end

  it 'has a valid product' do
    new_cart = Cart.new(
      user_id: user.id,
      product_id: product.id.split('-')[0]
    )
    expect(new_cart).to_not be_valid
    new_cart.product_id = product.id
    expect(new_cart).to be_valid
  end

  it 'has a valid quantity' do
    new_cart = Cart.new(
      user_id: user.id,
      product_id: product.id,
      quantity: 0
    )
    expect(new_cart).to_not be_valid
    new_cart.quantity = 10
    expect(new_cart).to be_valid
  end
end
