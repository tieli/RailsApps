# encoding: UTF-8
card     = Category.create! name: "Card"
dice     = Category.create! name: "Dice"
party    = Category.create! name: "Party"
board    = Category.create! name: "Board"
strategy = Category.create! name: "Strategy"
sports   = Category.create! name: "Sports"
action   = Category.create! name: "Action"
casual   = Category.create! name: "Casual"

Product.create! name: "Settlers of Catan",
  price_in_cents: 33.60,
  categories: [strategy, card, dice],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Agricola",
  price_in_cents: 42.24,
  categories: [strategy, card],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Stone Age",
  price_in_cents: 28.99,
  categories: [strategy, dice],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Puerto Rico",
  price_in_cents: 27.00,
  categories: [strategy],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Bohnanza",
  price_in_cents: 27.00,
  categories: [card],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Ticket to Ride",
  price_in_cents: 37.50,
  categories: [strategy, card],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Patchwork Board Game",
  price_in_cents: 27.99,
  categories: [strategy],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "7 Wonders Duel Board Game",
  price_in_cents: 27.99,
  categories: [strategy],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Codenames",
  price_in_cents: 19.95,
  categories: [strategy],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dungeon Lords Game",
  price_in_cents: 113.33,
  categories: [strategy, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Roll for The Galaxy Board Game",
  price_in_cents: 59.99,
  categories: [board],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dominion",
  price_in_cents: 27.97,
  categories: [card, board],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Clash of Kings",
  price_in_cents: 0.00,
  categories: [strategy, action],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "8 Ball Pool",
  price_in_cents: 0.00,
  categories: [sports],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Bowling King",
  price_in_cents: 0.00,
  categories: [sports],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Mini Pets",
  price_in_cents: 0.00,
  categories: [sports],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Soccer Stars",
  price_in_cents: 0.00,
  categories: [sports],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dino Pets",
  price_in_cents: 0.00,
  categories: [sports],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Rail Rush",
  price_in_cents: 0.00,
  categories: [sports],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Madden NFL Mobile",
  price_in_cents: 0.00,
  categories: [sports],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "True Skate",
  price_in_cents: 143,
  categories: [sports],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Scrabble",
  price_in_cents: 499,
  categories: [board],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Clash In Space",
  price_in_cents: 12305,
  categories: [casual],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "HandyCopter 3D Pro",
  price_in_cents: 998,
  categories: [casual],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

