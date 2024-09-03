class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts, id: :uuid do |t|
      t.string :session_id

      t.timestamps
    end
  end
end
