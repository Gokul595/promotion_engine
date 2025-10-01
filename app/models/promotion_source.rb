class PromotionSource < ApplicationRecord
  belongs_to :promotion
  belongs_to :source, polymorphic: true
end
