class Product < ApplicationRecord
  monetize :price_cents
  belongs_to :category
  has_one :cart

  validates_associated :category
  validates :name, uniqueness: true, presence: true
  validates :category_id, presence: true
  validates :stock, numericality: true
end
