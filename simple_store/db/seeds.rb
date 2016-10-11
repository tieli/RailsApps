# encoding: UTF-8

require "faker"

[Category, Tag, Product].each(&:delete_all)

card     = Category.create! name: "Card"
dice     = Category.create! name: "Dice"
board    = Category.create! name: "Board"
video    = Category.create! name: "Video"
category_list = [card, dice, board, video]

sports   = Tag.create! name: "Sports"
action   = Tag.create! name: "Action"
casual   = Tag.create! name: "Casual"
party    = Tag.create! name: "Party"
strategy = Tag.create! name: "Strategy"
foreign  = Tag.create! name: "Foreign"
domestic = Tag.create! name: "Domestic"
tag_list = [sports, action, casual, party, strategy, foreign, domestic]

Product.create! name: "Settlers of Catan",
  price_in_cents: 3360,
  stock: rand(1..10),
  category: category_list[rand(0..category_list.length-1)],
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Agricola",
  price_in_cents: 4224,
  stock: rand(1..10),
  category: card,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Stone Age",
  price_in_cents: 2899,
  stock: rand(1..10),
  category: board,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Puerto Rico",
  price_in_cents: 2700,
  stock: rand(1..10),
  category: board,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Bohnanza",
  price_in_cents: 2700,
  stock: rand(1..10),
  category: card,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Ticket to Ride",
  price_in_cents: 3750,
  stock: rand(1..10),
  category: dice,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Patchwork Board Game",
  price_in_cents: 2799,
  stock: rand(1..10),
  category: dice,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "7 Wonders Duel Board Game",
  price_in_cents: 2799,
  stock: rand(1..10),
  category: dice,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Codenames",
  price_in_cents: 1995,
  stock: rand(1..10),
  category: dice,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dungeon Lords Game",
  price_in_cents: 11333,
  stock: rand(1..10),
  category: category_list[rand(0..category_list.length-1)],
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Roll for The Galaxy Board Game",
  price_in_cents: 5999,
  stock: rand(1..10),
  category: Category.find(rand(1..4)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dominion",
  price_in_cents: 2797,
  stock: rand(1..10),
  category: Category.find(rand(1..4)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Clash of Kings",
  price_in_cents: 0.00,
  stock: rand(1..10),
  category: Category.find(rand(1..4)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "8 Ball Pool",
  price_in_cents: 0.00,
  stock: rand(1..10),
  category: Category.find(rand(1..4)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Bowling King",
  price_in_cents: 0.00,
  stock: rand(1..10),
  category: Category.find(rand(1..4)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Mini Pets",
  price_in_cents: 0.00,
  stock: rand(1..10),
  category: Category.find(rand(1..4)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Soccer Stars",
  price_in_cents: 0.00,
  stock: rand(1..10),
  category: Category.find(rand(1..4)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dino Pets",
  price_in_cents: 0.00,
  stock: rand(1..10),
  category: Category.find(rand(1..4)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Rail Rush",
  price_in_cents: 0.00,
  stock: rand(1..10),
  category: Category.find(rand(1..Category.count)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Madden NFL Mobile",
  price_in_cents: 0.00,
  stock: rand(1..10),
  category: Category.find(rand(1..Category.count)),
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "True Skate",
  price_in_cents: 143,
  stock: rand(1..10),
  category: card,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Scrabble",
  price_in_cents: 499,
  stock: rand(1..10),
  category: video,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Clash In Space",
  price_in_cents: 12305,
  stock: rand(1..10),
  category: video,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "HandyCopter 3D Pro",
  price_in_cents: 998,
  stock: rand(1..10),
  category: video,
  tags: tag_list.sample(rand(1..tag_list.length)),
  description: Faker::Lorem.paragraph(2),
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

