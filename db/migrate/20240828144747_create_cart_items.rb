class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items, id: :uuid do |t|
      t.references :cart, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
