# encoding: UTF-8

categories = %w|card dice party board strategy sports action casual|
category_list = categories.map { |category| Category.create! name: category } 

publishers = %w|days_of_wonder mayfair rio zman asmodee czech thames ea
                    true_axis allentony akadem elex miniclip|
publisher_list = publishers.map { |publisher| Publisher.create! name: publisher }

Product.create! name: "Settlers of Catan",
  price: 33.60,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Agricola",
  price: 42.24,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Stone Age",
  price: 28.99,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Puerto Rico",
  price: 27.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Bohnanza",
  price: 27.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Ticket to Ride",
  price: 37.50,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Patchwork Board Game",
  price: 27.99,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "7 Wonders Duel Board Game",
  price: 27.99,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Codenames",
  price: 19.95,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Dungeon Lords Game",
  price: 113.33,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Roll for The Galaxy Board Game",
  price: 59.99,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Dominion",
  price: 27.97,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Clash of Kings",
  price: 0.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "8 Ball Pool",
  price: 0.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Bowling King",
  price: 0.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Mini Pets",
  price: 0.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Soccer Stars",
  price: 0.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Dino Pets",
  price: 0.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Rail Rush",
  price: 0.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Madden NFL Mobile",
  price: 0.00,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "True Skate",
  price: 1.43,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Scrabble",
  price: 4.99,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Clash In Space",
  price: 123.05,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "HandyCopter 3D Pro",
  price: 9.99,
  publisher: Publisher.find(rand(1..Publisher.count())),
  categories: category_list.sample(rand(1..Category.count())),
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Order.delete_all
generator = proc do |start_time, end_time, shipping|
  time = Time.at(rand(end_time.to_i - start_time.to_i) + start_time.to_i)
  dollars = rand(200) + 10
  Order.create!(price: dollars, purchased_at: time, shipping: rand(shipping))
end
200.times { generator.call(10.days.ago, Time.zone.now.end_of_day, 1) }
500.times { generator.call(1.month.ago, Time.zone.now.end_of_day, 2) }
Order.create!(price: 10, purchased_at: 1.month.ago.beginning_of_day, shipping: true)

