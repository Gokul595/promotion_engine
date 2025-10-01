class CreatePromotions < ActiveRecord::Migration[7.2]
  def change
    create_table :promotions do |t|
      t.string :name
      t.integer :promo_type
      t.integer :discount_type
      t.integer :discount_value
      t.integer :min_unit
      t.integer :discount_quantity

      t.timestamps
    end
  end
end
