namespace :db do
  desc "Erase and populate database"
  task :populate => :environment do
    require "faker"
    require "populator"
    [Category, Product, Tag].each(&:delete_all)

    sports   = Tag.create! name: "Sports"
    action   = Tag.create! name: "Action"
    casual   = Tag.create! name: "Casual"
    party    = Tag.create! name: "Party"
    strategy = Tag.create! name: "Strategy"
    foreign  = Tag.create! name: "Foreign"
    domestic = Tag.create! name: "Domestic"
    tag_list = [sports, action, casual, party, strategy, foreign, domestic]

    Category.populate 20 do |category|
      category.name = Populator.words(3..5).titleize
      Product.populate 10..100 do |product|
        product.category_id = category.id
        product.name = Populator.words(3..5).titleize
        product.description = Populator.sentences(2..10)
        product.price_in_cents = [0, 450, 2000]
        product.released_at = 2.years.ago..Time.now
        product.tags = tag_list.sample(random(3))
      end
    end
  end
end
