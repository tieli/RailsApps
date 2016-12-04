# encoding: UTF-8

categories = %w|card dice party board strategy sports action casual|
category_list = categories.map { |category| Category.create! name: category } 

publishers = %w|days_of_wonder mayfair rio zman asmodee czech thames ea
                    true_axis allentony akadem elex miniclip|
publisher_list = publishers.map { |publisher| Publisher.create! name: publisher }

products = ["Settlers of Catan", "Agricola", "Stone Age", "Puerto Rico",
            "Bohnanza", "Ticket to Ride", "Patchwork Board Game",
            "7 Wonders Duel Board Game", "Codenames", "Dungeon Lords Game",
            "Roll for The Galaxy Board Game", "Dominion", "Clash of Kings",
            "8 Ball Pool", "Bowling King", "Mini Pets", "Soccer Stars",
            "Dino Pets", "Rail Rush", "Madden NFL Mobile", "True Skate",
            "Scrabble", "Clash In Space", "HandyCopter 3D Pro"]

products.each do |name|
  Product.create! name: name,
    price: rand(1.0...100.0),
    stock: rand(1..10),
    publisher: Publisher.find(rand(1..Publisher.count())),
    categories: category_list.sample(rand(1..Category.count())),
    released_on: rand(1..90).days.ago,
    discontinued: rand() < 0.2 ? true : false,
    rating: rand(1..5)
end

Order.delete_all
generator = proc do |start_time, end_time, shipping|
  time = Time.at(rand(end_time.to_i - start_time.to_i) + start_time.to_i)
  dollars = rand(200) + 10
  Order.create!(price: dollars, purchased_at: time, shipping: rand(shipping))
end
200.times { generator.call(10.days.ago, Time.zone.now.end_of_day, 1) }
500.times { generator.call(1.month.ago, Time.zone.now.end_of_day, 2) }
Order.create!(price: 10, purchased_at: 1.month.ago.beginning_of_day, shipping: true)

