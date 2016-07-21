# encoding: UTF-8
card     = Category.create! name: "Card"
dice     = Category.create! name: "Dice"
party    = Category.create! name: "Party"
board    = Category.create! name: "Board"
strategy = Category.create! name: "Strategy"

Product.create! name: "Settlers of Catan",
  price: 33.60,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: strategy

Product.create! name: "Agricola",
  price: 42.24,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: strategy

Product.create! name: "Stone Age",
  price: 28.99,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: strategy

Product.create! name: "Puerto Rico",
  price: 27.00,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: strategy

Product.create! name: "Bohnanza",
  price: 27.00,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: card

Product.create! name: "Ticket to Ride",
  price: 37.50,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: strategy

Product.create! name: "Patchwork Board Game",
  price: 27.99,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: strategy

Product.create! name: "7 Wonders Duel Board Game",
  price: 27.99,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: strategy

Product.create! name: "Codenames",
  price: 19.95,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: strategy

Product.create! name: "Dungeon Lords Game",
  price: 113.33,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: party

Product.create! name: "Roll for The Galaxy Board Game",
  price: 59.99,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: board

Product.create! name: "Dominion",
  price: 27.97,
  released_on: rand(1..90).days.ago,
  discontinued: rand() < 0.2 ? true : false,
  category: card

