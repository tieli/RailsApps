
# This file should contain all the record creation needed to seed the
# database with its default values.
# The data can then be loaded with the rake db:seed (or created
# alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

require 'open-uri'

def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def rand_price(from, to)
  rand_in_range(from, to).round(2)
end

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

namespace :db do
  namespace :populate do
    desc "Populate blog apps database"
    task :article => :environment do
      require "faker"
      Article.delete_all()
      User.delete_all()
      User.create!(email: "tiejli@yahoo.com", password: "password")
      User.create!(email: "tiejli@hotmail.com", password: "password")
      100.times do
        record = {
          :title        => Faker::Lorem.sentence,
          :content      => Faker::Lorem.paragraph(2),
          :published_at => rand_time(10.years.ago),
          :hidden       => rand() > 0.2 ? true : false,
          :user_id      => rand() > 0.5 ? 1 : 2
        }
        Article.create! record
      end
    end
    desc "Populate store apps database"
    task :product => :environment do
      100.times do
      end
    end
  end
end

