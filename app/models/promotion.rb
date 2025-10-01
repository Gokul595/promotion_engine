class Promotion < ApplicationRecord
  enum status: { active: 0, inactive: 1 }
  enum promo_type: { percentage: 0, fixed_amount: 1, weight_threshold: 2, buy_x_get_y: 3 }, _prefix: :promo
  enum discount_type: { percentage: 0, fixed_amount: 1 }, _prefix: :discount

  has_many :promotion_sources, dependent: :destroy
  has_many :items, through: :promotion_sources, source: :source, source_type: 'Item'
  has_many :categories, through: :promotion_sources, source: :source, source_type: 'Category'
end
