class User < ApplicationRecord
  include Clearance::User
  has_many :carts
  has_many :products, through: :carts

  validates :email, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, presence: true
end
