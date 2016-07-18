# encoding: UTF-8
card = Category.create! name: "Card"
dice = Category.create! name: "Dice"
party = Category.create! name: "Party"
strategy = Category.create! name: "Strategy"

days_of_wonder = Publisher.create! name: "Days of Wonder"
mayfair = Publisher.create! name: "Mayfair Games"
rio = Publisher.create! name: "Rio Grande Games"
zman = Publisher.create! name: "Z-Man Games"

Product.create! name: "Settlers of Catan",
  price: 33.60,
  publisher: mayfair,
  categories: [strategy, card, dice],
  released_on: rand(1..90).days.ago,
  rating: 5

Product.create! name: "Agricola",
  price: 42.24,
  publisher: zman,
  categories: [strategy, card],
  released_on: rand(1..90).days.ago,
  rating: 5

Product.create! name: "Stone Age",
  price: 28.99,
  publisher: rio,
  categories: [strategy, dice],
  released_on: rand(1..90).days.ago,
  rating: 5

Product.create! name: "Puerto Rico",
  price: 27.00,
  publisher: rio,
  categories: [strategy],
  released_on: rand(1..90).days.ago,
  rating: 5

Product.create! name: "Bohnanza",
  price: 27.00,
  publisher: rio,
  categories: [card],
  released_on: rand(1..90).days.ago,
  rating: 5

Product.create! name: "Ticket to Ride",
  price: 37.50,
  publisher: days_of_wonder,
  categories: [strategy, card],
  released_on: rand(1..90).days.ago,
  rating: 4

