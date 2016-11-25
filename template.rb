
repo = "https://raw.githubusercontent.com/tieli/rails-apps/master/"

app_css            = 'app/assets/stylesheets/application.css'
app_scss           = 'app/assets/stylesheets/application.scss'
app_css_scss       = 'app/assets/stylesheets/application.css.scss'
forms_css_scss     = 'app/assets/stylesheets/forms.css.scss'

app_erb            = 'app/views/layouts/application.html.erb'
app_html_erb       = 'app/views/layouts/application.html.erb'
app_haml           = 'app/views/layouts/application.html.haml'
app_html_haml      = 'app/views/layouts/application.html.haml'

app_helpers_layout = 'app/helpers/layout_helper.rb'


scaffolds_css      = 'app/assets/stylesheets/scaffolds.css'
scaffolds_scss     = 'app/assets/stylesheets/scaffolds.scss'
scaffolds_css_scss = 'app/assets/stylesheets/scaffolds.css.scss'
app_js             = 'app/assets/javascripts/application.js'

devise_reg_edit = "app/views/devise/registrations/edit.html.erb"
devise_reg_new  = "app/views/devise/registrations/new.html.erb"
devise_ses_new  = "app/views/devise/sessions/new.html.erb"

config_dev         = 'config/environments/development.rb'
config_test        = 'config/environments/test.rb'
config_routes      = 'config/routes.rb'

av = 'app/views/'
am = 'app/models/'
ac = 'app/controllers/'
aa = 'app/assets/'

user_rb    = 'app/models/user.rb'
article_rb = 'app/models/article.rb'

@prefs = {}
@gems = []

@diagnostics_prefs = []
diagnostics = {}

##########################
#  templates/hepers.erb  #
##########################

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

def get_gen_str(type, res_desc, options = {})
  name = res_desc[0]
  fields = res_desc[1]
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
  fields.each { |k,v| str << " " << k << ":" << v }
  options.each { |k,v| str << " " << "--" + k << " " << v }
  str
end

prefs[:apps4] = multiple_choice "Build a Rails Apps?",
    [["Build a Basic Rails App", "basic"],
    ["Build a Simple Blog App", "simple_blogs"],
    ["Build a Simple Store App", "simple_store"],
    ["Build a Rails Blog App", "blogs"],
    ["Build a Rails Store App", "store"],
    ["Build a Rails Todo List(Ajax)", "todos"],
    ["Build a Movies Review App", "movie_review"],
    ["Custom Application (experimental)", "none"],
    ["Quit", "quit"]]

exit if prefs[:apps4] == "quit"

gem_group :development, :test do
  gem "bullet"
  gem "better_errors", "~> 2.1", ">= 2.1.1"
  gem "binding_of_caller", "~> 0.7.2"
  gem "meta_request"
end

gem_group :development, :test do
  gem 'capybara', '~> 2.7', '>= 2.7.1'
  gem 'poltergeist', '~> 1.10'
  gem 'launchy-rails'
  gem 'rack-mini-profiler'
end

gem 'paperclip', '~> 5.1'
gem "haml", version: ">= 4.0.7"
gem 'will_paginate', '~> 3.1.0'
gem 'acts_as_votable', '~> 0.10.0'
gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'

gem 'ruby-prof'
gem 'rails-perftest', '~> 0.0.6'
gem 'hirb', '~> 0.7.3'
gem 'awesome_print', '~> 1.7'
gem 'methodfinder', '~> 2.0'
gem 'fancy_irb', '~> 0.6.0'

gem 'pry', '~> 0.10.4'
gem 'pry-doc', '~> 0.9.0'
gem 'commands'

gem 'faker', '~> 1.6', '>= 1.6.6'
gem 'html2haml', '~> 2.0'

uncomment_lines 'Gemfile', /bcrypt/

run "bundle install"

########################
#  Common Rails Tasks  #
########################

common_files = [ 'lib/tasks/setup.thor',
                 'lib/tasks/haml.rake', 
                 'lib/tasks/populate.rake',
                 'lib/tasks/list.rake']

common_files.each do |from_file|
  copy_from_repo "shared", from_file, :repo => repo
end

###############################
#  Select Frontend Framework  #
###############################

prefs[:frontend] = multiple_choice "Front End Framework?",
    [["Baisc", "basic"],
    ["Twitter Bootstrap", "bootstrap"],
    ["Zurb Foundation", "foundation"],
    ["No Frontend Framework", "no_frontend"]]

##########################
#  Select Authencation   #
##########################

prefs[:auth] = multiple_choice "Authentication?",
    [["No Authentication", "no_auth"],
    ["Basic Authentication", "basic"],
    ["Authlogic", "authlogic"],
    ["Sorcery", "sorcery"],
    ["Warden", "warden"],
    ["Omni Authentication", "omniauth"],
    ["Devise", "devise"]]

##############################
#  Select Testing Framework  #
##############################

prefs[:test] = multiple_choice "Testing Framework?",
    [["Test::Unit", "test_unit"],
    ["Rspec", "rspec"],
    ["Minitest::Test", "minitest"]]

case prefs[:test]

when 'test_unit'

when 'rspec'
  gem_group :development, :test do
    gem "rspec-rails"
    gem 'factory_girl_rails', '~> 4.7'
  end
  
  run "bundle install"
  generate "rspec:install"

  #Add config.include Capybara::DSL in spec/rails_helper.rb
  inject_into_file 'spec/rails_helper.rb', after: "RSpec.configure do |config|\n" do <<-'RUBY'
  #config.filter_run focus: true
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  RUBY
  end

when 'minitest'

  gem_group :development, :test do
    gem 'minitest-rails', '~> 2.2', '>= 2.2.1'
  end

  run "bundle install"
  generate "minitest:install"

end

###################################
#  Layout and Stylesheet files    #
###################################

app_files = [ scaffolds_css_scss, app_helpers_layout, app_html_erb ]

case prefs[:frontend]
when 'basic'
  if prefs[:auth] == 'no_auth'
    app_name = "frontend/no_auth"
  elsif prefs[:auth] == 'authlogic'
    app_name = "frontend/authlogic"
  elsif prefs[:auth] == 'sorcery'
    app_name = "frontend/sorcery"
  elsif prefs[:auth] == 'warden'
    app_name = "frontend/warden"
  elsif prefs[:auth] == 'omni'
    app_name = "frontend/omni"
  else
    app_name = "frontend/basic_auth"
  end
when 'bootstrap'
  abort("Auth method is required") if prefs[:auth] == 'no_auth'
    app_name = "frontend/bootstrap"

  gem 'simple_form', '~> 3.2', '>= 3.2.1'
  gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'

  run "bundle install"

  generate "simple_form:install --bootstrap"

  append_to_file app_js do <<-'RUBY'
  //= require jquery-ui
  //= require bootstrap-sprockets
  RUBY
  end

  app_files = [ app_html_erb, app_css_scss ]

  remove_file app_css

when 'foundation'
  abort("Auth method is required") if prefs[:auth] == 'no_auth'
    app_name = "frontend/foundation"

  gem 'zurb-foundation'
  generate "foundation:install --force"

end

app_files.each do |from_file|
  copy_from_repo app_name, from_file, :repo => repo
end

case prefs[:auth]
when 'no_auth'
when 'basic'
  generate "resource", "user username email password_digest" 
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

  generate "integration_test", "password_reset" 
  generate "integration_test", "users_signup" 
  generate "integration_test", "users_login" 

  inject_into_file config_routes, after: "routes.draw do\n" do <<-'RUBY'
  get 'login', to: 'sessions#new', as: 'login'
  get 'signup', to: 'users#new', as: 'signup'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  resources :sessions
  resources :password_resets
  RUBY
  end

  comment_lines config_routes, /password_resets\/new/
  comment_lines config_routes, /sessions\/new/

  app_files = ['app/models/user.rb',
               'app/views/users/new.html.erb',
               'app/views/users/show.html.erb',
               'app/views/sessions/new.html.erb',
               'app/views/user_mailer/password_reset.text.erb',
               'app/views/password_resets/edit.html.erb',
               'app/views/password_resets/new.html.erb',
               'app/controllers/application_controller.rb',
               'app/controllers/users_controller.rb',
               'app/controllers/sessions_controller.rb',
               'app/controllers/password_resets_controller.rb',
               'app/mailers/user_mailer.rb',
               'app/helpers/application_helper.rb',
               'test/mailers/user_mailer_test.rb',
               'test/models/user_test.rb',
               'test/integration/users_signup_test.rb',
               'test/integration/users_login_test.rb',
               'spec/factories/users.rb',
               'spec/models/user_spec.rb',
               'spec/requests/password_resets_spec.rb']
  app_name = "auth/basic"

when 'authlogic'

  gem 'authlogic', '~> 3.4', '>= 3.4.6'
  run "bundle install"

  user_model = ["User", { "email" => "string",
                          "crypted_password" => "string",
                          "password_salt" => "string",
                          "persistence_token" => "string" }]
  generate get_gen_str("scaffold", user_model)

  inject_into_file user_rb, after: "class User < ActiveRecord::Base\n" do <<-'RUBY'
  acts_as_authentic
  RUBY
  end

  app_files = ['app/views/users/_form.html.erb',
               'app/views/shared/_errors.html.erb',
               'app/views/user_sessions/new.html.erb',
               config_routes,
               'app/models/user_session.rb',
               'app/controllers/user_sessions_controller.rb',
               'app/controllers/application_controller.rb',
               'app/controllers/users_controller.rb']
  app_name = "auth/authlogic"

when 'sorcery'
  gem 'sorcery', '~> 0.9.1'
  run "bundle install"

  run "rails g sorcery:install"

  user_model = ["User", { "email" => "string",
                          "crypted_password" => "string",
                          "salt" => "string" }]
  options = { "migration" => "false" }
  generate get_gen_str("scaffold", user_model, options)

  inject_into_file user_rb, after: "class User < ActiveRecord::Base\n" do <<-'RUBY'
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  RUBY
  end

  app_files = ['app/views/users/_form.html.erb',
               'app/views/user_sessions/new.html.erb',
               'app/views/user_sessions/_form.html.erb',
               config_routes,
               'app/controllers/user_sessions_controller.rb',
               'app/controllers/users_controller.rb']
  app_name = "auth/sorcery"

when 'warden'
  gem 'warden', '~> 1.2', '>= 1.2.6'
  run "bundle install"

  generate "resource", "user username email password_digest" 
  generate "controller", "sessions new" 

  inject_into_file user_rb, after: "class User < ActiveRecord::Base\n" do <<-'RUBY'
  has_secure_password
  RUBY
  end

  app_files = [ config_routes,
               'app/models/user.rb',
               'app/views/users/new.html.erb',
               'app/views/sessions/create.html.erb',
               'app/views/sessions/new.html.erb',
               'app/controllers/user_sessions_controller.rb',
               'app/controllers/users_controller.rb',
               'app/controllers/application_controller.rb']
  app_name = "auth/warden"

when 'omniauth'
  gem 'omniauth-twitter', '~> 1.2', '>= 1.2.1'
  app_files = ['config/initializers/omniauth.rb']
  app_name = "auth/omni"

when 'devise'
  gem 'devise', '~> 4.2'
  run "bundle install"

  generate "devise:install"
  generate "devise:views"
  generate "devise User"

  [config_dev, config_test].each do 
    inject_into_file config_dev, after: "Rails.application.configure do\n" do <<-'RUBY'
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    RUBY
    end
  end

  inject_into_file config_routes, after: "devise_for :users\n" do <<-'RUBY'
  devise_scope :user do
    get '/sign_in', to: 'devise/sessions#new', as: 'login'
    get '/sign_up', to: 'devise/registrations#new', as: 'signup'
    delete '/sign_out', to: 'devise/sessions#destroy', as: 'logout'
  end
  RUBY
  end

end

app_files.each do |from_file|
  copy_from_repo app_name, from_file, :repo => repo
end


app_files = []
app_name = prefs[:apps4]

case prefs[:apps4]
when 'basic'

  #app_files = [ scaffolds_css_scss, app_helpers_layout, app_erb ]
  app_files = []

  generate "controller", "welcome home"
  route "root to: 'welcome\#home'"

when 'simple_blogs'

  article_model = ["Article", {"title" => "string",
                               "hidden" => "boolean",
                               "content" => "text",
                               "published_at" => "datetime"}]
  generate get_gen_str("scaffold", article_model)

#  generate "resource", "user email password_digest" 
#  generate "controller", "sessions new" 

  if prefs[:auth] != "no_auth"
    article_user_migration = ["add_user_id_to_articles", 
                             {"user_id" => "integer"} ]
    generate get_gen_str("migration", article_user_migration)

    inject_into_file article_rb, before: "end" do <<-'RUBY'
    belongs_to :user
    RUBY
    end

    inject_into_file user_rb, after: "User < ActiveRecord::Base\n" do <<-'RUBY'
    has_many :articles
    RUBY
    end
  end

  app_files = [ #scaffolds_css_scss, app_html_erb,
                forms_css_scss,
                #"config/routes.rb",
                #"app/views/users/new.html.erb",
                #"app/views/sessions/new.html.erb",
                "app/views/articles/index.html.erb",
                #user_rb,
                article_rb,
                #"app/models/user.rb",
                "app/models/article.rb",
                #"app/controllers/application_controller.rb",
                "app/controllers/articles_controller.rb",
                #"app/controllers/sessions_controller.rb",
                #"app/controllers/users_controller.rb"
              ]

  gem 'simple_form', '~> 3.2', '>= 3.2.1'
  generate "simple_form:install"

  inject_into_file config_dev, after: "Rails.application.configure do\n" do <<-'RUBY'
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  RUBY
  end

  inject_into_file config_test, after: "Rails.application.configure do\n" do <<-'RUBY'
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  RUBY
  end

  route "root to: 'articles\#index'"

  rake "db:migrate"

when "simple_store"

  product_model = ["Product", { "name" => "string",
                                "stock" => "integer",
                                "description" => "text",
                                "price_in_cents" => "decimal",
                                "released_at" => "datetime",
                                "discontinued" => "boolean" }]
  generate get_gen_str("scaffold", product_model)

  tag_model     = ["tag", {"name" => "string" } ]
  generate get_gen_str("model", tag_model)

  tagging_model = ["tagging", {"tag" => "belongs_to",
                            "product" => "belongs_to" } ]
  generate get_gen_str("model", tagging_model)

  category_model = ["Category", { "name" => "string" } ]
  generate get_gen_str("model", category_model)

  product_category_migration = ["add_category_id_to_products", 
                             {"category_id" => "integer"} ]
  generate get_gen_str("migration", product_category_migration)

  app_files = [ #scaffolds_css_scss, app_html_erb,
               'db/seeds.rb',
               'app/views/products/index.html.erb',
               'app/views/products/_form.html.erb',
               'app/views/products/show.html.erb',
               'app/views/products/labeled_form_builder.rb',
               'app/controllers/products_controller.rb' ]

  product_model_file = 'app/models/product.rb'
  inject_into_file product_model_file, after: "class Product < ActiveRecord::Base\n" do <<-'RUBY'
  belongs_to :category
  has_many :taggings
  has_many :tags, through: :taggings
  RUBY
  end

  inject_into_file 'app/models/category.rb', before: "end" do <<-'RUBY'
  has_many :products
  RUBY
  end

  inject_into_file 'app/models/tag.rb', before: "end" do <<-'RUBY'
  has_many :taggings
  has_many :products, through: :taggings
  RUBY
  end

  route "root to: 'products\#index'"

when 'blogs'

  article_model = ["Article", {"title" => "string",
                               "content" => "text",
                               "hidden" => "boolean",
                               "published_at" => "datetime" }]
  generate get_gen_str("scaffold", article_model)

  comment_model = ["Comment", {"commenter" => "string",
                               "content" => "text",
                               "article" => "references" } ]
  generate get_gen_str("model", comment_model)

  category_model = ["Category", { "name" => "string" } ]
  generate get_gen_str("model", category_model)

  article_category_migration = ["add_category_id_to_articles", 
                             {"category_id" => "integer"} ]
  generate get_gen_str("migration", article_category_migration)

  tag_model     = ["tag", {"name" => "string" } ]
  generate get_gen_str("model", tag_model)

  tagging_model = ["tagging", {"tag" => "belongs_to",
                            "article" => "belongs_to" } ]
  generate get_gen_str("model", tagging_model)

  generate "controller", "comments" 

  generate "model", "announcement message:text starts_at:datetime ends_at:datetime" 

  route "root to: 'articles\#index'"

  app_files = ['config/routes.rb',
               'db/seeds.rb',
               app_css_scss, scaffolds_scss, app_erb,
               'app/assets/stylesheets/articles.scss',
               'app/assets/stylesheets/announcements.scss',
               'app/models/announcement.rb',
               'app/models/article.rb',
               'app/models/comment.rb',
               'app/models/tag.rb',
               'app/views/articles/new.html.erb',
               'app/views/articles/index.html.erb',
               'app/views/articles/show.html.erb',
               'app/views/articles/_form.html.erb',
               'app/views/comments/_comment.html.erb',
               'app/views/comments/edit.html.erb',
               'app/views/comments/_form.html.erb',
               'app/views/layouts/application.html.erb',
               'app/views/layouts/mailer.text.erb',
               'app/controllers/application_controller.rb',
               'app/controllers/articles_controller.rb',
               'app/controllers/comments_controller.rb',
               'app/controllers/announcements_controller.rb',
               'test/fixtures/articles.yml',
               'test/fixtures/categories.yml',
               'spec/models/announcement_spec.rb',
               'spec/requests/announcements_spec.rb' ]

  [config_dev, config_test].each do |item|
    inject_into_file item, after: "Rails.application.configure do\n" do <<-'RUBY'
    config.action_mailer.default_url_options = { :host => "http://127.0.0.1:23000" }
    RUBY
    end
  end

when 'store'

  model = ["Product", { "name" => "string",
                        "price" => "decimal",
                        "stock" => "integer",
                        "rating" => "integer",
                        "released_on" => "date",
                        "category_id" => "integer",
                        "publisher_id" => "integer",
                        "discontinued" => "boolean" }]
  generate get_gen_str("scaffold", model)

  model = ["Order", { "price" => "decimal", 
                      "purchased_at" => "datetime",
                      "shipping" => "boolean" }]
  generate get_gen_str("scaffold", model)

  model = ["Publisher", { "name" => "string" } ]
  generate get_gen_str("model", model)

  model = ["Categorization", {
           "product_id" => "integer", "category_id" => "integer" }]
  generate get_gen_str("model", model)

  model = ["Category", { "name" => "string" } ]
  generate get_gen_str("model", model)

  route "root to: 'products\#index'"

  app_files = ['db/seeds.rb',
               'config/routes.rb',
               #app_scss, app_html_erb, scaffolds_scss,
               'app/assets/images/up_arrow.gif',
               'app/assets/images/down_arrow.gif',
               'app/models/product.rb',
               'app/models/publisher.rb',
               'app/models/category.rb',
               'app/models/categorization.rb',
               'app/views/orders/index.html.erb',
               'app/views/products/index.html.erb',
               'app/views/products/summary.html.erb',
               'app/views/products/_footer.html.erb',
               'app/views/products/_form.html.erb',
               'app/views/shared/_footer.html.erb',
               'app/controllers/orders_controller.rb',
               'app/controllers/products_controller.rb',
               'app/helpers/application_helper.rb' ]

  gem 'simple_form', '~> 3.2', '>= 3.2.1'
  generate "simple_form:install --bootstrap"

when 'movie_review'

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

  gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
  gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'

  gem 'devise', '~> 4.2'
  generate "devise:install"
  generate "devise:views"
  generate "devise User"

  generate "paperclip movie image"

  if prefs[:auth] != "no_auth"
    movie_user_migration = ["add_user_id_to_movies", 
                            { "user_id" => "integer" } ]
  end

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
               'app/controllers/movies_controller.rb' ]

  comment_lines 'config/routes.rb', /resources :movies/
  route "resources :movies do\n resources :reviews\nend"
  route "resources :directors"

  rake "db:populate"

end

rake "db:migrate"

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

