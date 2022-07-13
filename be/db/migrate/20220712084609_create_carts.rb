class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :product, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
