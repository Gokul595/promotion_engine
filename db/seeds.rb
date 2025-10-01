# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding Categories"
tshirt_category = Category.find_or_create_by!(name: 'T-Shirts')
hoodies_category = Category.find_or_create_by!(name: 'Hoodies')
jogger_category = Category.find_or_create_by!(name: 'Joggers')

puts "Seeding Items"
white_tee = Item.find_or_create_by!(name: 'Basic White T-Shirt', category: tshirt_category) do |item|
  item.description = 'A classic white t-shirt made from 100% cotton. Perfect for everyday wear.'
  item.actual_price = 15.00
  item.selling_price = 12.00
  item.weight_in_grams = 400
end

graphic_tee = Item.find_or_create_by!(name: 'Graphic Tee', category: tshirt_category) do |item|
  item.description = 'A trendy graphic tee with a unique design. Made from a soft cotton blend.'
  item.actual_price = 20.00
  item.selling_price = 16.00
  item.weight_in_grams = 400
end

black_tee = Item.find_or_create_by!(name: 'Basic Black T-Shirt', category: tshirt_category) do |item|
  item.description = 'A classic black t-shirt made from 100% cotton. Perfect for everyday wear.'
  item.actual_price = 15.00
  item.selling_price = 12.00
  item.weight_in_grams = 400
end

green_tee = Item.find_or_create_by!(name: 'Basic Green T-Shirt', category: tshirt_category) do |item|
  item.description = 'A classic green t-shirt made from 100% cotton. Perfect for everyday wear.'
  item.actual_price = 15.00
  item.selling_price = 12.00
  item.weight_in_grams = 400
end

Item.find_or_create_by!(name: 'Zip-Up Hoodie', category: hoodies_category) do |item|
  item.description = 'A comfortable zip-up hoodie with a fleece lining. Great for layering in cooler weather.'
  item.actual_price = 40.00
  item.selling_price = 32.00
  item.weight_in_grams = 700
end

Item.find_or_create_by!(name: 'Pullover Hoodie', category: hoodies_category) do |item|
  item.description = 'A cozy pullover hoodie with a kangaroo pocket. Made from a warm cotton blend.'
  item.actual_price = 35.00
  item.selling_price = 28.00
  item.weight_in_grams = 700
end

Item.find_or_create_by!(name: 'Athletic Hoodie', category: hoodies_category) do |item|
  item.description = 'A lightweight athletic hoodie designed for workouts. Moisture-wicking fabric keeps you dry.'
  item.actual_price = 45.00
  item.selling_price = 36.00
  item.weight_in_grams = 700
end

Item.find_or_create_by!(name: 'Super soft Hoodie', category: hoodies_category) do |item|
  item.description = 'A lightweight super soft hoodie designed for casual wear.'
  item.actual_price = 45.00
  item.selling_price = 33.00
  item.weight_in_grams = 700
end

Item.find_or_create_by!(name: 'Slim Fit Joggers', category: jogger_category) do |item|
  item.description = 'Stylish slim fit joggers made from a soft and stretchy fabric. Perfect for casual wear.'
  item.actual_price = 30.00
  item.selling_price = 24.00
  item.weight_in_grams = 800
end

Item.find_or_create_by!(name: 'Classic Joggers', category: jogger_category) do |item|
  item.description = 'Comfortable classic joggers with an elastic waistband and cuffs. Made from a breathable cotton blend.'
  item.actual_price = 25.00
  item.selling_price = 20.00
  item.weight_in_grams = 800
end

puts "Seeding Promotions"

# Example: Flat $10 off on all items
flat_fee_promo = Promotion.find_or_create_by!(name: 'Flat $10 Off', promo_type: :fixed_amount) do |promo|
  promo.discount_type = :fixed_amount
  promo.discount_value = 10.00
end

# Example: Flat 15% off on all items in the Jogger category
percentage_promo = Promotion.find_or_create_by!(name: 'Flat 15% Off', promo_type: :percentage) do |promo|
  promo.discount_type = :percentage
  promo.discount_value = 15
  promo.categories << jogger_category
end

# Example: 10% off for orders over 5kg 
weight_threshold_promo = Promotion.find_or_create_by!(name: '10% Off Over 5kg', promo_type: :weight_threshold) do |promo|
  promo.discount_type = :percentage
  promo.discount_value = 10
  promo.min_unit = 1000 # in grams
  promo.items = [white_tee, graphic_tee]
end

# Example: Buy 2 Get 1 Free
buy_x_get_y_promo = Promotion.find_or_create_by!(name: 'Buy 2 Get 1 Free', promo_type: :buy_x_get_y) do |promo|
  promo.discount_type = :percentage # Free item is treated as 100% off
  promo.discount_value = 100 # 100% off
  promo.discount_quantity = 1
  promo.min_unit = 2
  promo.categories = [hoodies_category]
end

# Example: Buy 2 Get 2 50% off
buy_x_get_y_percent_promo = Promotion.find_or_create_by!(name: 'Buy 2 Get 2 50% off', promo_type: :buy_x_get_y) do |promo|
  promo.discount_type = :percentage
  promo.discount_value = 50 # 50% off
  promo.discount_quantity = 2
  promo.min_unit = 2
  promo.categories = [tshirt_category]
end

puts "Seeding completed."
