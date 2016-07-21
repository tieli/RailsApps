# encoding: UTF-8
card     = Category.create! name: "Card"
dice     = Category.create! name: "Dice"
party    = Category.create! name: "Party"
board    = Category.create! name: "Board"
strategy = Category.create! name: "Strategy"

Product.create! name: "Settlers of Catan",
  price: 33.60,
  category: strategy

Product.create! name: "Agricola",
  price: 42.24,
  category: strategy

Product.create! name: "Stone Age",
  price: 28.99,
  category: strategy

Product.create! name: "Puerto Rico",
  price: 27.00,
  category: strategy

Product.create! name: "Bohnanza",
  price: 27.00,
  category: card

Product.create! name: "Ticket to Ride",
  price: 37.50,
  category: strategy

Product.create! name: "Patchwork Board Game",
  price: 27.99,
  category: strategy

Product.create! name: "7 Wonders Duel Board Game",
  price: 27.99,
  category: strategy

Product.create! name: "Codenames",
  price: 19.95,
  category: strategy

Product.create! name: "Dungeon Lords Game",
  price: 113.33,
  category: party

Product.create! name: "Roll for The Galaxy Board Game",
  price: 59.99,
  category: board

Product.create! name: "Dominion",
  price: 27.97,
  category: card

