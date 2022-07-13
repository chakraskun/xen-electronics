class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.string :description
      t.monetize :price
      t.string :image_url
      t.integer :stock, null: false, default: 0
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
