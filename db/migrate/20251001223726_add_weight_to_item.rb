class AddWeightToItem < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :weight_in_grams, :integer
  end
end
