# encoding: UTF-8
card     = Category.create! name: "Card"
dice     = Category.create! name: "Dice"
board    = Category.create! name: "Board"
video    = Category.create! name: "Video"

sports   = Tag.create! name: "Sports"
action   = Tag.create! name: "Action"
casual   = Tag.create! name: "Casual"
party    = Tag.create! name: "Party"
strategy = Tag.create! name: "Strategy"
foreign  = Tag.create! name: "Foreign"
domestic = Tag.create! name: "Domestic"
  tags: [sports, casual, party, foreign],

Product.create! name: "Settlers of Catan",
  price_in_cents: 3360,
  category: cart,
  tags: [sports, casual, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Agricola",
  price_in_cents: 4224,
  category: card,
  tags: [sports, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Stone Age",
  price_in_cents: 2899,
  category: board,
  tags: [sports, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Puerto Rico",
  price_in_cents: 2700,
  category: board,
  tags: [sports, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Bohnanza",
  price_in_cents: 2700,
  category: card,
  tags: [sports, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Ticket to Ride",
  price_in_cents: 3750,
  category: dice,
  tags: [sports, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Patchwork Board Game",
  price_in_cents: 2799,
  category: dice,
  tags: [sports, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "7 Wonders Duel Board Game",
  price_in_cents: 2799,
  category: dice,
  tags: [sports, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Codenames",
  price_in_cents: 1995,
  category: dice,
  tags: [sports, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dungeon Lords Game",
  price_in_cents: 11333,
  category: board,
  tags: [sports, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Roll for The Galaxy Board Game",
  price_in_cents: 5999,
  category: Category.find(rand(1..4)),
  tags: [casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dominion",
  price_in_cents: 2797,
  category: Category.find(rand(1..4)),
  tags: [sports, casual, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Clash of Kings",
  price_in_cents: 0.00,
  category: Category.find(rand(1..4)),
  tags: [sports, casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "8 Ball Pool",
  price_in_cents: 0.00,
  category: Category.find(rand(1..4)),
  tags: [sports, casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Bowling King",
  price_in_cents: 0.00,
  category: Category.find(rand(1..4)),
  tags: [sports, casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Mini Pets",
  price_in_cents: 0.00,
  category: Category.find(rand(1..4)),
  tags: [sports, casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Soccer Stars",
  price_in_cents: 0.00,
  category: Category.find(rand(1..4)),
  tags: [sports, casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Dino Pets",
  price_in_cents: 0.00,
  category: Category.find(rand(1..4)),
  tags: [sports, casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Rail Rush",
  price_in_cents: 0.00,
  category: Category.find(rand(1..Category.count)),
  tags: [sports, casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Madden NFL Mobile",
  price_in_cents: 0.00,
  category: Category.find(rand(1..Category.count)),
  tags: [sports, casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "True Skate",
  price_in_cents: 143,
  category: [sports],
  tags: [sports, casual, party, foreign],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Scrabble",
  price_in_cents: 499,
  category: video,
  tags: [sports, casual, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "Clash In Space",
  price_in_cents: 12305,
  category: video,
  tags: [sports, casual, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

Product.create! name: "HandyCopter 3D Pro",
  price_in_cents: 998,
  category: video,
  tags: [sports, casual, party],
  released_at: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false

