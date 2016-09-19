
repo = "https://raw.githubusercontent.com/tieli/RailsApps/master/"

app_css            = 'app/assets/stylesheets/application.css'
app_css_scss       = 'app/assets/stylesheets/application.css.scss'
app_erb            = 'app/views/layouts/application.html.erb'
app_haml           = 'app/views/layouts/application.html.haml'
scaffolds_scss     = 'app/assets/stylesheets/scaffolds.scss'
scaffolds_css_scss = 'app/assets/stylesheets/scaffolds.css.scss'
app_js             = 'app/assets/javascripts/application.js'

config_dev         = 'config/environments/development.rb'

av = 'app/views/'
am = 'app/models/'
ac = 'app/controllers/'
aa = 'app/assets/'

@prefs = {}
@gems = []

@diagnostics_prefs = []
diagnostics = {}

# --------------------------- 
# templates/helpers.erb 
# ---------------------------
def recipes 
  @recipes 
end

def recipe?(name) 
  @recipes.include?(name) 
end

def prefs 
  @prefs 
end

def prefer(key, value) 
  @prefs[key].eql? value 
end

def gems 
  @gems 
end

def diagnostics_recipes 
  @diagnostics_recipes 
end

def diagnostics_prefs 
  @diagnostics_prefs 
end

# Colored Output
def colorize(text, color_code)
  "\033[1m\033[#{color_code}m#{text}\033[0m"
end

def red(text) 
  colorize(text, 31) 
end

def cyan(text)
  colorize(text, 36) 
end

def green(text) 
  colorize(text, 32) 
end

def yellow(text) 
  colorize(text, 33) 
end

def say_custom(tag, text) 
    say cyan(tag.to_s.rjust(10)) + "  #{text}" 
end

def say_loud(tag, text) 
    say cyan(tag.to_s.rjust(10) + "  #{text}")
end

def say_recipe(name) 
    say cyan("recipe".rjust(10)) + "  Running #{name}" 
end

def say_wizard(text) 
    say_custom(@current_recipe || 'composer', text) 
end

def ask_wizard(question)
  ask cyan(("choose").rjust(10)) + "  #{question}" 
end

def multiple_choice(question, choices)
  say_custom('option', question)
  values = {}
  choices.each_with_index do |choice,i|
    values[(i + 1).to_s] = choice[1]
    say_custom( (i + 1).to_s + ')', choice[0] )
  end

  begin 
    answer = ask_wizard("Enter your selection:") 
  end while(!values.keys.include?(answer))

  values[answer]
end

def html_to_haml(source)
  begin
    html = open(source) {|input| input.binmode.read }
    Haml::HTML.new(html, :erb => true, :xhtml => true).render
  rescue RubyParser::SyntaxError
    say_wizard "Ignoring RubyParser::SyntaxError"
    # special case to accommodate https://github.com/RailsApps/rails-composer/issues/55
    html = open(source) {|input| input.binmode.read }
    say_wizard "applying patch" if html.include? 'card_month'
    say_wizard "applying patch" if html.include? 'card_year'
    html = html.gsub(/, {add_month_numbers: true}, {name: nil, id: "card_month"}/, '')
    html = html.gsub(/, {start_year: Date\.today\.year, end_year: Date\.today\.year\+10}, {name: nil, id: "card_year"}/, '')
    result = Haml::HTML.new(html, :erb => true, :xhtml => true).render
    result = result.gsub(/select_month nil/, "select_month nil, {add_month_numbers: true}, {name: nil, id: \"card_month\"}")
    result = result.gsub(/select_year nil/, "select_year nil, {start_year: Date.today.year, end_year: Date.today.year+10}, {name: nil, id: \"card_year\"}")
  end
end

def copy_from_repo(app_name, file_name, opts = {})

  repo = opts[:repo] unless opts[:repo].nil?
  if (!opts[:prefs].nil?) && (!prefs.has_value? opts[:prefs])
    return
  end
  source_filename = app_name + "/" + file_name
  destination_filename = file_name

  unless opts[:prefs].nil?
    if filename.include? opts[:prefs]
      destination_filename = filename.gsub(/\-#{opts[:prefs]}/, '')
    end
  end
  if (prefer :templates, 'haml') && (filename.include? 'views')
    remove_file destination_filename
    destination_filename = destination_filename.gsub(/.erb/, '.haml')
  end
  if (prefer :templates, 'slim') && (filename.include? 'views')
    remove_file destination_filename
    destination_filename = destination_filename.gsub(/.erb/, '.slim')
  end
  begin
    remove_file destination_filename
    if (prefer :templates, 'haml') && (filename.include? 'views')
      create_file destination_filename, html_to_haml(repo + source_filename)
    elsif (prefer :templates, 'slim') && (filename.include? 'views')
      create_file destination_filename, html_to_slim(repo + source_filename)
    else
      get repo + source_filename, destination_filename
    end
  rescue OpenURI::HTTPError
    say_wizard "Unable to obtain #{source_filename} from the repo #{repo}"
  end

end

def get_gen_str(type, res_desc)
  name = res_desc[0]
  str = " " + type + " "
  case type
  when 'scaffold'
    str = str + name.pluralize(1)
  when 'model'
    str = str + name.pluralize(1)
  when 'resource'
    str = str + name.pluralize(2)
  when 'migration'
    str = str + name
  when 'mailer'
    str = str + name
  end
  res_desc[1].each { |k,v| str << " " << k << ":" << v }
  str
end

prefs[:apps4] = multiple_choice "Build a Rails Apps?",
    [["Build a Basic Rails App", "basic"],
    ["Build a Rails App with bootstrap", "basic_bootstrap"],
    ["Build a Rails Blog App", "blogs"],
    ["Build a Simple Blog App", "simple_blogs"],
    ["Build a Rails Store App", "store"],
    ["Build a Simple Store App", "simple_store"],
    ["Build a Store App using Zerb Foundation", "store_foundation"],
    ["Build a Movies Review App", "movie_review"],
    ["Custom application (experimental)", "none"],
    ["Quit", "quit"]]

exit if prefs[:apps4] == "quit"

uncomment_lines 'Gemfile', /bcrypt/

gem_group :development do
  gem "pry", "~> 0.10.4"
  gem "bullet"
  gem "meta_request"
  gem "better_errors", "~> 2.1", ">= 2.1.1"
  gem "binding_of_caller", "~> 0.7.2"
end

gem "haml", version: ">= 4.0.7"
gem 'will_paginate', '~> 3.1.0'
gem 'acts_as_votable', '~> 0.10.0'
gem 'paperclip', '~> 5.1'
gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'

gem_group :development, :test do
  gem 'minitest', '~> 5.8', '>= 5.8.4'
  gem 'capybara', '~> 2.7', '>= 2.7.1'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'faker', '~> 1.6', '>= 1.6.5'
  gem "rspec-rails"
end

gem 'hirb', '~> 0.7.3'

run "bundle install"

app_files = []
app_name = ""

case prefs[:apps4]
when 'basic'

when 'basic_bootstrap'

  app_name = prefs[:apps4]

  gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
  gem 'devise', '~> 4.2'
  gem 'simple_form', '~> 3.2', '>= 3.2.1'

  run "bundle install"

  generate "simple_form:install --bootstrap"
  generate "devise:install"
  generate "devise:views"
  generate "devise User"

  append_to_file app_js do <<-'RUBY'
  //= require jquery-ui
  //= require bootstrap-sprockets
  RUBY
  end

  inject_into_file config_dev, after: "Rails.application.configure do\n" do <<-'RUBY'
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  RUBY
  end

  app_files = [ app_haml, app_css_scss,
                "app/views/devise/registrations/edit.html.erb",
                "app/views/devise/registrations/new.html.erb",
                "app/views/devise/sessions/new.html.erb" ]

  generate "controller", "welcome index" 
  route "root to: 'welcome\#index'"

  remove_file app_css

when 'simple_blogs'

  app_name = prefs[:apps4]

  article_model = ["Article", {"title" => "string",
                               "hidden" => "boolean",
                               "content" => "text",
                               "published_at" => "datetime"}]
  generate get_gen_str("scaffold", article_model)

  app_files = [ app_scss, scaffolds_scss, app_erb ]

  route "root to: 'articles\#index'"
  rake "db:migrate"

when 'blogs'

  app_name = prefs[:apps4]

  article_model = ["Article", {"title" => "string",
                               "content" => "text",
                               "hidden" => "boolean",
                               "published_at" => "datetime" }]
  generate get_gen_str("scaffold", article_model)

  comment_model = ["Comment", {"commenter" => "string",
                               "content" => "text",
                               "article" => "references" } ]
  generate get_gen_str("model", comment_model)

  tag_model     = ["tag", {"name" => "string" } ]
  generate get_gen_str("model", tag_model)

  tagging_model = ["tagging", {"tag" => "belongs_to",
                            "article" => "belongs_to" } ]
  generate get_gen_str("model", tagging_model)

  generate "controller", "comments" 

  generate "resource", "user email password_digest" 
  generate "controller", "sessions new" 
  generate "controller", "password_resets new" 

  user_auth_token_migration = ["add_auth_token_to_users", 
                          { "auth_token" => "string" } ]
  generate get_gen_str("migration", user_auth_token_migration)

  password_reset_migration = ["add_password_reset_token_to_users", 
                          {"password_reset_token" => "string" ,
                           "password_reset_sent_at" => "datetime" } ]
  generate get_gen_str("migration", password_reset_migration)

  user_mailer = ["user_mailer",
                {"password_reset" => "string" }]

  generate get_gen_str("mailer", user_mailer)

  route "root to: 'articles\#index'"

  app_files = ['config/routes.rb',
               'db/seeds.rb',
               app_css_scss, scaffolds_scss, app_erb,
               'app/models/article.rb',
               'app/models/user.rb',
               'app/models/tag.rb',
               'app/views/articles/new.html.erb',
               'app/views/articles/index.html.erb',
               'app/views/articles/show.html.erb',
               'app/views/articles/_form.html.erb',
               'app/views/comments/_comment.html.erb',
               'app/views/comments/edit.html.erb',
               'app/views/comments/_form.html.erb',
               'app/views/sessions/new.html.erb',
               'app/views/users/new.html.erb',
               'app/views/user_mailer/password_reset.text.erb',
               'app/views/password_resets/edit.html.erb',
               'app/views/password_resets/new.html.erb',
               'app/views/layouts/mailer.text.erb',
               'app/controllers/application_controller.rb',
               'app/controllers/users_controller.rb',
               'app/controllers/articles_controller.rb',
               'app/controllers/comments_controller.rb',
               'app/controllers/sessions_controller.rb',
               'app/controllers/password_resets_controller.rb',
               'app/mailers/user_mailer.rb',
               'app/helpers/application_helper.rb' ]

  inject_into_file config_dev, after: "Rails.application.configure do\n" do <<-'RUBY'
  config.action_mailer.default_url_options = { :host => "http://127.0.0.1:23000" }
  RUBY
  end

when "simple_store"

  app_name = prefs[:apps4]

  product_model = ["Product", { "name" => "string",
                                "price_in_cents" => "decimal",
                                "released_at" => "datetime",
                                "discontinued" => "boolean" }]
  generate get_gen_str("scaffold", product_model)

  category_model = ["Category", { "name" => "string" } ]
  generate get_gen_str("model", category_model)

  product_category_migration = ["create_categories_products", 
                             { "product" => "references",
                              "category" => "references" } ]
  generate get_gen_str("migration", product_category_migration)

  app_files = ['db/seeds.rb',
               scaffolds_css_scss, app_erb,
               'app/views/products/index.html.erb',
               'app/views/products/_form.html.erb',
               'app/views/products/show.html.erb',
               'app/controllers/products_controller.rb' ]

  inject_into_file 'app/models/category.rb', before: "end" do <<-'RUBY'
  has_and_belongs_to_many :products
  RUBY
  end

  inject_into_file 'app/models/product.rb', before: "end" do <<-'RUBY'
  has_and_belongs_to_many :categories
  RUBY
  end

  route "root to: 'products\#index'"

when 'store'

  app_name = prefs[:apps4]

  gem 'simple_form', '~> 3.2', '>= 3.2.1'

  product_model = ["Product", { "name" => "string",
                                "price" => "decimal",
                                "rating" => "integer",
                                "released_on" => "date",
                                "category_id" => "integer",
                                "publisher_id" => "integer",
                                "discontinued" => "boolean" }]
  generate get_gen_str("scaffold", product_model)

  publisher_model = ["Publisher", { "name" => "string" } ]
  generate get_gen_str("model", publisher_model)

  categorization_model = ["Categorization", {
           "product_id" => "integer", "category_id" => "integer" }]
  generate get_gen_str("model", categorization_model)

  category_model = ["Category", { "name" => "string" } ]
  generate get_gen_str("model", category_model)

  route "root to: 'products\#index'"

  app_files = ['db/seeds.rb',
               'config/routes.rb',
               app_scss, app_erb, scaffolds_scss,
               'app/assets/images/up_arrow.gif',
               'app/assets/images/down_arrow.gif',
               'app/models/product.rb',
               'app/models/publisher.rb',
               'app/models/category.rb',
               'app/models/categorization.rb',
               'app/views/products/index.html.erb',
               'app/views/products/summary.html.erb',
               'app/views/products/_footer.html.erb',
               'app/views/products/_form.html.erb',
               'app/controllers/products_controller.rb',
               'app/helpers/application_helper.rb' ]

  generate "simple_form:install --bootstrap"

when 'store_foundation'

  app_name = prefs[:apps4]

  product_model = ["Product", { "name" => "string",
                                "price" => "decimal",
                                "released_on" => "date" }]

  generate get_gen_str("scaffold", product_model) + " --skip-stylesheets"

  route "root to: 'products\#index'"

  gem 'zurb-foundation'
  generate "foundation:install --force"

when 'movie_review'

  app_name = prefs[:apps4]

  movie_model = ["Movie", { "title" => "string",
                            "year" => "integer",
                            "rating" => "string",
                            "director_id" => "integer",
                            "description" => "text",
                            "movie_length" => "string" }]
  generate get_gen_str("scaffold", movie_model)

  director_model = ["Director", {"name" => "string" }]
  generate get_gen_str("model", director_model)

  actor_model    = ["Actor", {"name" => "string" }]
  generate get_gen_str("model", actor_model)

  acting_model   = ["Acting", {"actor" => "belongs_to",
                            "movie" => "belongs_to" } ]
  generate get_gen_str("model", acting_model)

  review_model = ["Review", { "comment" => "text",
                              "rating" => "string",
                              "movie_id" => "integer" } ]
  generate get_gen_str("model", review_model)

  generate "controller", "directors" 

  gem 'devise', '~> 4.2'
  gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
  gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'

  generate "devise:install"
  generate "devise:views"
  generate "devise User"
  generate "paperclip movie image"

  movie_user_migration = ["add_user_id_to_movies", 
                          { "user_id" => "integer" } ]

  generate get_gen_str("migration", movie_user_migration)

  route "root to: 'movies\#index'"

  inject_into_file config_dev, after: "Rails.application.configure do\n" do <<-'RUBY'
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  RUBY
  end

  movie_model_file = 'app/models/movie.rb'
  inject_into_file movie_model_file, after: "class Movie < ActiveRecord::Base\n" do <<-'RUBY'
  belongs_to :user
  belongs_to :director
  has_many :actings
  has_many :actors, through: :actings
  has_many :reviews
  has_attached_file :image, styles: { medium: "400x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def actor_list_in_string
    actors.pluck(:name).join(",")
  end

  RUBY
  end

  review_model_file = 'app/models/review.rb'
  inject_into_file review_model_file, after: "class Review < ActiveRecord::Base\n" do <<-'RUBY'
  belongs_to :movie
  RUBY
  end

  actor_model_file = 'app/models/actor.rb'
  inject_into_file actor_model_file, after: "class Actor < ActiveRecord::Base\n" do <<-'RUBY'
  has_many :actings
  has_many :movies, through: :actings
  RUBY
  end

  user_model_file = 'app/models/user.rb'
  inject_into_file user_model_file, after: "class User < ActiveRecord::Base\n" do <<-'RUBY'
  has_many :movies
  RUBY
  end

  director_model_file = 'app/models/director.rb'
  inject_into_file director_model_file, after: "class Director < ActiveRecord::Base\n" do <<-'RUBY'
  has_many :movies
  RUBY
  end

  director_controller_file = 'app/controllers/directors_controller.rb'
  inject_into_file director_controller_file, after: "class DirectorsController < ApplicationController\n" do <<-'RUBY'
  def index
    @directors = Director.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @directors.map(&:name)
  end
  RUBY
  end

  application_file = "app/assets/stylesheets/application"
  copy_file "#{application_file}.css", "#{application_file}.scss"
  append_to_file "#{application_file}.scss" do <<-'RUBY'
  @import "bootstrap-sprockets";
  @import "bootstrap";
  RUBY
  end

  append_to_file app_js do <<-'RUBY'
  //= require jquery-ui
  //= require bootstrap-sprockets
  RUBY
  end

  app_files = ['db/seeds.rb', 
               app_scss, app_erb, 
               'app/assets/javascripts/movies.coffee',
               'app/assets/stylesheets/movies.scss',
               'app/assets/images/1.jpg',
               'app/views/movies/index.html.erb',
               'app/views/movies/show.html.erb',
               'app/views/movies/_form.html.erb',
               'app/views/reviews/_form.html.erb',
               'app/views/reviews/_review.html.erb',
               'app/views/devise/sessions/new.html.erb',
               'app/views/devise/registrations/edit.html.erb',
               'app/views/devise/registrations/new.html.erb',
               'app/controllers/reviews_controller.rb',
               'app/controllers/movies_controller.rb',
               'lib/tasks/populate.rake' ]

  comment_lines 'config/routes.rb', /resources :movies/
  route "resources :movies do\n resources :reviews\nend"
  route "resources :directors"

  rake "db:populate"

end

rake "db:migrate"

generate "rspec:install"
capify!

inject_into_file 'bin/rails', before: "require \'rails/commands\'" do <<-'RUBY'
# Set default host and port to rails server
if ARGV.first == 's' || ARGV.first == 'server'
  require 'rails/commands/server'
  module Rails
    class Server
      def default_options
        super.merge(Host:  '0.0.0.0', Port: 3000)
      end
    end
  end
end
RUBY
end

app_files.each do |from_file|
  copy_from_repo app_name, from_file, :repo => repo
end

remove_file "README.rdoc"
remove_file "public/index.html"

append_file ".gitignore", "config/database.yml"
#copy_file "config/database.yml", "config/example_database.yml"

git :init
git add: ".", commit: "-m 'initial commit'"

rake "db:seed"

