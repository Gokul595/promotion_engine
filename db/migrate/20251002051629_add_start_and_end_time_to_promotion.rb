class AddStartAndEndTimeToPromotion < ActiveRecord::Migration[7.2]
  def change
    add_column :promotions, :start_time, :datetime
    add_column :promotions, :end_time, :datetime
  end
end
