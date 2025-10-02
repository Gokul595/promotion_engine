# README - Promotion Engine

## Local Setup

### Prerequisites
```markdown
- Ruby (version 3.2.2)
- Bundler
- MySQL
- Node.js and Yarn (for JavaScript dependencies)
```

### Steps
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Install Ruby dependencies:
   ```bash
   bundle install
   ```

3. Install JavaScript dependencies:
   ```bash
   yarn install
   ```

4. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. Running tests:
   ```bash
   rake test
   ```

6. Start the Rails server:
   ```bash
   rails server
   ```

7. Open the application in your browser:
   ```
   http://localhost:3000
   ```

## Application Overview
### Seeded Data

- The application comes with pre-seeded data for items, categories, and promotions.

### Items & Categories

- To view list of categories visit `/categories`
- To view list of items from all the categories visit `/items`

### Cart - Add/Remove

- Cart can be accessed from `/cart` page
- Current cart ID will be stored in the session and will be used for all cart related actions
- Items can be added to the cart by clicking "Add to Cart" button from the individual item page `/items/:id`
- Items can be removed from the cart by clicking "Remove from Cart" button from the cart page `/cart`
- Clicking "Add to Cart" again on the same item will increase the quantity of that item in the cart
- Cart will show the items added, their quantities, individual prices, total price before discount, total discount applied and final price after discount

### Promotions

#### Different types of promotions supported:
- Flat fee discount (ex: 20 dollars off on an item)
- Percentage discount (ex: 10% of off an item)
- Buy X Get Y discount (ex: Buy 1 get one free, buy 3 get 1 50% off)
- Weight threshold discounts (ex: buy more than 100 grams and get 50% off the item)
- Promotions can be valid for individual items, or categories (ex: 50% off on all products of X category)

#### Promotion Application Logic:
- All promotion calculation logic are present in `lib/promotion_engine.rb`
- Promotions should have a start time and optional end time
- Only active promotions (current time is between start and end time) will be applied
- Promotions can be created for specific items or categories
- Promotions are applied automatically when items are added to the cart, removed from the cart and when the quantity changes
- Multiple promotions can be applied to the cart
- If multiple promotions are applicable to the same item, the promotion that gives the maximum discount will be applied

## Assumptions
- An item can belong to only one category
- Promotions can be created for either an item or a category, but not both at the same time
- No user authentication is implemented; cart is managed via session
- All prices are in USD
- No option to manually apply or remove promotions; they are applied automatically based on the rules defined
- No option to create or manage items, categories, or promotions via the UI; they are pre-seeded in the database
- No option to update item quantities directly in the cart; quantities can only be changed by adding or removing items
- Buy X Get Y promotion will get highest priority than other promotions
