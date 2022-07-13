require 'rails_helper'

RSpec.describe Product, type: :model do
  category = Category.first_or_create(name: 'sound', image_url: 'some_url')
  it 'has a name' do
    new_product = Product.new(
      name: '',
      image_url: 'some_url',
      description: 'some_description',
      price_cents: 100,
      stock: 10,
      category_id: category.id
    )
    expect(new_product).to_not be_valid
    new_product.name = 'random_name_product'
    expect(new_product).to be_valid
  end

  it 'has a valid category' do
    new_product = Product.new(
      name: 'random_name_product',
      image_url: 'some_url',
      description: 'some_description',
      price_cents: 100,
      stock: 10,
      category_id: category.id.split('-')[0]
    )
    expect(new_product).to_not be_valid
    new_product.category_id = category.id
    expect(new_product).to be_valid
  end

  it 'has a valid number of stock' do
    new_product = Product.new(
      name: 'random_name_product',
      image_url: 'some_url',
      description: 'some_description',
      price_cents: 100,
      stock: 'stock',
      category_id: category.id
    )
    expect(new_product).to_not be_valid
    new_product.stock = 15
    expect(new_product).to be_valid
  end
end
