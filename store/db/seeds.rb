# encoding: UTF-8
card     = Category.create! name: "Card"
dice     = Category.create! name: "Dice"
party    = Category.create! name: "Party"
board    = Category.create! name: "Board"
strategy = Category.create! name: "Strategy"
sports   = Category.create! name: "Sports"
action   = Category.create! name: "Action"
casual   = Category.create! name: "Casual"

days_of_wonder = Publisher.create! name: "Days of Wonder"
mayfair        = Publisher.create! name: "Mayfair Games"
rio            = Publisher.create! name: "Rio Grande Games"
zman           = Publisher.create! name: "Z-Man Games"
asmodee        = Publisher.create! name: "Asmodee"
czech          = Publisher.create! name: "Czech Games"
thames         = Publisher.create! name: "Thames & Kosmos"
ea             = Publisher.create! name: "Electronic Arts"
true_axis      = Publisher.create! name: "True Axis"
allentony      = Publisher.create! name: "Allen Tony"
akadem         = Publisher.create! name: "Akadem"

Product.create! name: "Settlers of Catan",
  price: 33.60,
  publisher: mayfair,
  categories: [strategy, card, dice],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Agricola",
  price: 42.24,
  publisher: zman,
  categories: [strategy, card],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Stone Age",
  price: 28.99,
  publisher: rio,
  categories: [strategy, dice],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Puerto Rico",
  price: 27.00,
  publisher: rio,
  categories: [strategy],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Bohnanza",
  price: 27.00,
  publisher: rio,
  categories: [card],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Ticket to Ride",
  price: 37.50,
  publisher: days_of_wonder,
  categories: [strategy, card],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Patchwork Board Game",
  price: 27.99,
  publisher: mayfair,
  categories: [strategy],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "7 Wonders Duel Board Game",
  price: 27.99,
  publisher: asmodee,
  categories: [strategy],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Codenames",
  price: 19.95,
  publisher: czech,
  categories: [strategy],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Dungeon Lords Game",
  price: 113.33,
  publisher: czech,
  categories: [strategy, party],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Roll for The Galaxy Board Game",
  price: 59.99,
  publisher: rio,
  categories: [board],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Dominion",
  price: 27.97,
  publisher: rio,
  categories: [card, board],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Clash of Kings",
  price: 0.00,
  publisher: elex,
  categories: [strategy, action],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "8 Ball Pool",
  price: 0.00,
  publisher: miniclip,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Bowling King",
  price: 0.00,
  publisher: miniclip,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Mini Pets",
  price: 0.00,
  publisher: miniclip,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Soccer Stars",
  price: 0.00,
  publisher: miniclip,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Dino Pets",
  price: 0.00,
  publisher: miniclip,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Rail Rush",
  price: 0.00,
  publisher: miniclip,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Madden NFL Mobile",
  price: 0.00,
  publisher: ea,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "True Skate",
  price: 1.43,
  publisher: true_axis,
  categories: [sports],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Scrabble",
  price: 4.99,
  publisher: ea,
  categories: [board],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "Clash In Space",
  price: 123.05,
  publisher: allentony,
  categories: [casual],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

Product.create! name: "HandyCopter 3D Pro",
  price: 9.99,
  publisher: akadem,
  categories: [casual],
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  rating: rand(1..5)

