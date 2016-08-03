# encoding: UTF-8
require 'bcrypt'

user_tiejli = User.create!  email: "tiejli@yahoo.com",
    :password => 'password', 
    :password_confirmation => 'password'

yimou_zhang = Director.create! name: "Yimou Zhang"

# http://www.imdb.com/list/ls055592025/
movie_records = [["The Lord of Rings", "Peter Jackson"],
                 ["Inception", "Christopher Nolan"],
                 ["The Jackal", "Christopher Nolan"],
                 ["The Godfather", "Francis Ford Coppola"],
                 ["The Shawshank Redemption", "Frank Darabont"],
                 ["Schindler's List", "Steven Spielberg"],
                 ["Psycho", "Alfred Hitchcock"],
                 ["Forrest Gump", "Robert Zemeckis"],
                 ["Star Wars: Episode IV - A New Hope", "George Lucas"],
                 ["2001: A Space Odyssey", "Stanley Kubrick"],
                 ["The Silence of the Lambs", "Jonathan Demme"]]

movie_records.each_with_index { |record, index| 
  Movie.create! title: record.first,
    description: <<-RUBY,
    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
    RUBY
    director: yimou_zhang,
    movie_length: "100",
    user: user_tiejli,
    image: File.open("#{Rails.root}/app/assets/images/#{index}.jpg")
}

