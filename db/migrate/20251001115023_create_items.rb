class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.float :actual_price
      t.float :selling_price

      t.timestamps
    end
  end
end
