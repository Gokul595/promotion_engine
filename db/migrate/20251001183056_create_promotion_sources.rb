class CreatePromotionSources < ActiveRecord::Migration[7.2]
  def change
    create_table :promotion_sources do |t|
      t.references :promotion, null: false, foreign_key: true
      t.references :source, polymorphic: true, null: false

      t.timestamps
    end
  end
end
