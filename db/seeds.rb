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
tshirt_category = Category.create!(name: 'T-Shirts')
hoodies_category = Category.create!(name: 'Hoodies')
jogger_category = Category.create!(name: 'Joggers')

puts "Seeding Items"
Item.find_or_create_by!(name: 'Basic White T-Shirt', category: tshirt_category) do |item|
  item.description = 'A classic white t-shirt made from 100% cotton. Perfect for everyday wear.'
  item.actual_price = 15.00
  item.selling_price = 12.00
end

Item.find_or_create_by!(name: 'Graphic Tee', category: tshirt_category) do |item|
  item.description = 'A trendy graphic tee with a unique design. Made from a soft cotton blend.'
  item.actual_price = 20.00
  item.selling_price = 16.00
end

Item.find_or_create_by!(name: 'Zip-Up Hoodie', category: hoodies_category) do |item|
  item.description = 'A comfortable zip-up hoodie with a fleece lining. Great for layering in cooler weather.'
  item.actual_price = 40.00
  item.selling_price = 32.00
end

Item.find_or_create_by!(name: 'Pullover Hoodie', category: hoodies_category) do |item|
  item.description = 'A cozy pullover hoodie with a kangaroo pocket. Made from a warm cotton blend.'
  item.actual_price = 35.00
  item.selling_price = 28.00
end

Item.find_or_create_by!(name: 'Slim Fit Joggers', category: jogger_category) do |item|
  item.description = 'Stylish slim fit joggers made from a soft and stretchy fabric. Perfect for casual wear.'
  item.actual_price = 30.00
  item.selling_price = 24.00
end

Item.find_or_create_by!(name: 'Classic Joggers', category: jogger_category) do |item|
  item.description = 'Comfortable classic joggers with an elastic waistband and cuffs. Made from a breathable cotton blend.'
  item.actual_price = 25.00
  item.selling_price = 20.00
end

puts "Seeding completed."
