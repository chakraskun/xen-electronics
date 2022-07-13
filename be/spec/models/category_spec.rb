require 'rails_helper'

RSpec.describe Category, type: :model do
  Category.find_or_create_by(name: 'sound', image_url: 'some_url')
  it 'has a name' do
    new_category = Category.new(
      name: '',
      image_url: 'some_url'
    )
    expect(new_category).to_not be_valid
    new_category.name = 'electronics_test'
    expect(new_category).to be_valid
  end

  it 'has to be unique' do
    new_category = Category.new(
      name: 'sound',
      image_url: 'some_url'
    )
    expect(new_category).to_not be_valid
  end
end
