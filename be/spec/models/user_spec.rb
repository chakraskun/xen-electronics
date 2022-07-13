require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a email' do
    user = User.new(
      email: '',
      password: '123456'
    )
    expect(user).to_not be_valid
    user.email = 'test2@gmail.com'
    expect(user).to be_valid
    user.email = 'notvalidemail'
    expect(user).to_not be_valid
  end

  it 'has a password' do
    user = User.new(
      email: 'test2@gmail.com',
      password: ''
    )
    expect(user).to_not be_valid
    user.password = 'qwertyyuip'
    expect(user).to be_valid
  end
end
