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
  price: 33.60,
  categories: [strategy, card, dice],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Agricola",
  price: 42.24,
  categories: [strategy, card],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Stone Age",
  price: 28.99,
  categories: [strategy, dice],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Puerto Rico",
  price: 27.00,
  categories: [strategy],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Bohnanza",
  price: 27.00,
  categories: [card],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Ticket to Ride",
  price: 37.50,
  categories: [strategy, card],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Patchwork Board Game",
  price: 27.99,
  categories: [strategy],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "7 Wonders Duel Board Game",
  price: 27.99,
  categories: [strategy],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Codenames",
  price: 19.95,
  categories: [strategy],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dungeon Lords Game",
  price: 113.33,
  categories: [strategy, party],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Roll for The Galaxy Board Game",
  price: 59.99,
  categories: [board],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dominion",
  price: 27.97,
  categories: [card, board],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Clash of Kings",
  price: 0.00,
  categories: [strategy, action],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "8 Ball Pool",
  price: 0.00,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Bowling King",
  price: 0.00,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Mini Pets",
  price: 0.00,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Soccer Stars",
  price: 0.00,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dino Pets",
  price: 0.00,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Rail Rush",
  price: 0.00,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Madden NFL Mobile",
  price: 0.00,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "True Skate",
  price: 1.43,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Scrabble",
  price: 4.99,
  categories: [board],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Clash In Space",
  price: 123.05,
  categories: [casual],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "HandyCopter 3D Pro",
  price: 9.99,
  categories: [casual],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

