class PromotionEngine
  def initialize(cart)
    @cart = cart
  end

  # Logic to apply promotions to the cart
  # This could involve checking the items in the cart against active promotions
  # and adding discounts accordingly.
  def apply_promotions
    promotions = Promotion.active.includes(:items, :categories) # Fetch all active promotions
    cart_items = @cart.cart_items.includes(item: :category)

    cart_items.update_all(discount_value: 0) # Reset all discounts before reapplying

    promotions.each do |promotion|
      case promotion.promo_type
      when 'percentage'
        apply_percentage_promotion(promotion, cart_items)
      when 'fixed_amount'
        apply_fixed_amount_promotion(promotion, cart_items)
      when 'weight_threshold'
        apply_weight_threshold_promotion(promotion, cart_items)
      when 'buy_x_get_y'
        apply_buy_x_get_y_promotion(promotion, cart_items)
      end
    end

    @cart.update(total_price: cart_items.sum(&:total_price_after_discount))
  end

  private

  def valid_promotion?(promotion, cart_item)
    return true unless promotion.promotion_sources.present?

    promotion.items.include?(cart_item.item) || promotion.categories.include?(cart_item.item.category)
  end

  def apply_percentage_promotion(promotion, cart_items)
    cart_items.each do |cart_item|
      if valid_promotion?(promotion, cart_item)
        discount = (cart_item.item.selling_price * cart_item.quantity) * (promotion.discount_value.to_f / 100.0)

        # Ensure highest discount is applied for each item
        cart_item.update(promotion_id: promotion.id, discount_value: discount) if discount > cart_item.discount_value
      end
    end
  end

  def apply_fixed_amount_promotion(promotion, cart_items)
    cart_items.each do |cart_item|
      if valid_promotion?(promotion, cart_item)
        discount = [promotion.discount_value, cart_item.item.selling_price].min * cart_item.quantity

        # Ensure highest discount is applied for each item
        cart_item.update(promotion_id: promotion.id, discount_value: discount) if discount > cart_item.discount_value
      end
    end
  end

  def apply_weight_threshold_promotion(promotion, cart_items)
    total_weight = cart_items.sum { |ci| ci.item.weight_in_grams.to_f * ci.quantity }

    if total_weight >= promotion.min_unit
      cart_items.each do |cart_item|
        if valid_promotion?(promotion, cart_item)
          discount = (cart_item.item.selling_price * cart_item.quantity) * (promotion.discount_value.to_f / 100.0)

          # Ensure highest discount is applied for each item
          cart_item.update(promotion_id: promotion.id, discount_value: discount) if discount > cart_item.discount_value
        end
      end
    end
  end

  def apply_buy_x_get_y_promotion(promotion, cart_items)
    eligible_cart_items = cart_items.select { |ci| valid_promotion?(promotion, ci) }
    total_eligible_quantity = eligible_cart_items.sum(&:quantity)

    if total_eligible_quantity >= promotion.min_unit
      free_items_count = (total_eligible_quantity / (promotion.min_unit + promotion.discount_quantity)) * promotion.discount_quantity

      # Sort eligible cart items by price to apply discount for the lowest priced items first
      eligible_cart_items.sort_by! { |ci| ci.item.selling_price }

      eligible_cart_items.each do |cart_item|
        break if free_items_count <= 0

        discount_quantity = [cart_item.quantity, free_items_count].min
        discount = (cart_item.item.selling_price * discount_quantity) * (promotion.discount_value.to_f / 100)

        # Ensure highest discount is applied for each item
        cart_item.update(promotion_id: promotion.id, discount_value: discount) if discount > cart_item.discount_value

        free_items_count -= discount_quantity
      end
    end
  end
end