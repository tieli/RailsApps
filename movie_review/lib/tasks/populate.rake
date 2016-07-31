namespace :db do

  desc "Populate the database"
  task :populate => :environment do
    [User, Movie].each(&:delete_all)

    "http://www.imdb.com/list/ls055592025/"
    require 'nokogiri'
    require 'open-uri'

    user_tiejli = User.create!  email: "tiejli@yahoo.com",
        :password => 'password', 
        :password_confirmation => 'password'

    url = "http://www.imdb.com/list/ls055592025/"
    doc = Nokogiri::HTML(open(url))
    doc.css(".list_item").each do |item|
      image_link  = item.at_css(".image img")[:src]
      title       = item.css(".info b a").text
      year        = item.at_css(".info .year_type").text
      description = item.at_css(".info .item_description").text
      length      = item.at_css(".info .item_description span").text[/\d+/]
      director    = item.css(".secondary")[0].text.split(" ", 2).second
      Movie.create! title: title,
        description: description,
        director: director,
        movie_length: length,
        user: user_tiejli,
        image: open(image_link)
    end
  end


end
