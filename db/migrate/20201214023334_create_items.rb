class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title,            null: false
      t.text :profile,            null: false
      t.integer :category_id,     null: false
      t.integer :status_id,       null: false
      t.integer :delivery_fee_id, null: false
      t.integer :prefecture_id,   null: false
      t.integer :days_to_ship_id, null: false
      t.integer :price,           null: false
      t.references :user,         foreign_key: false
      t.timestamps
    end
  end
end
