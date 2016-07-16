
@recipes = ["core", "git", "railsapps", "learn_rails", "rails_bootstrap", "rails_foundation", "rails_omniauth", "rails_devise", "rails_devise_roles", "rails_devise_pundit", "rails_signup_download", "rails_mailinglist_activejob", "rails_stripe_checkout", "rails_stripe_coupons", "rails_stripe_membership_saas", "setup", "locale", "readme", "gems", "tests", "email", "devise", "omniauth", "roles", "frontend", "pages", "init", "analytics", "deployment", "extras"]
@prefs = {}
@gems = []

@diagnostics_recipes = [["example"], ["setup"], ["railsapps"], ["gems", "setup"], ["gems", "readme", "setup"], ["extras", "gems", "readme", "setup"], ["example", "git"], ["git", "setup"], ["git", "railsapps"], ["gems", "git", "setup"], ["gems", "git", "readme", "setup"], ["extras", "gems", "git", "readme", "setup"], ["email", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "testing"], ["core", "email", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "testing"], ["core", "email", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "testing"], ["core", "email", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "testing"], ["email", "example", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "testing"], ["email", "example", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "testing"], ["email", "example", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "testing"], ["apps4", "core", "email", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "testing"], ["apps4", "core", "email", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "tests"], ["apps4", "core", "deployment", "email", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "testing"], ["apps4", "core", "deployment", "email", "extras", "frontend", "gems", "git", "init", "railsapps", "readme", "setup", "tests"], ["apps4", "core", "deployment", "devise", "email", "extras", "frontend", "gems", "git", "init", "omniauth", "pundit", "railsapps", "readme", "setup", "tests"]]

@diagnostics_prefs = []
diagnostics = {}

# --------------------------- 
# templates/helpers.erb 
# ---------------------------
def recipes; @recipes end
def recipe?(name); @recipes.include?(name) end
def prefs; @prefs end
def prefer(key, value); @prefs[key].eql? value end
def gems; @gems end
def diagnostics_recipes; @diagnostics_recipes end
def diagnostics_prefs; @diagnostics_prefs end

# Colored Output
def colorize(text, color_code)
  "\033[1m\033[#{color_code}m#{text}\033[0m"
end

def red(text); colorize(text, 31); end
def cyan(text); colorize(text, 36); end
def green(text); colorize(text, 32); end
def yellow(text); colorize(text, 33); end

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

choise = ""

choise = multiple_choice "Build a Rails Apps?",
    [["Build a Rails Blog App", "railsblogs"],
    ["Build a Rails Shop App", "railsshop"],
    ["Custom application (experimental)", "none"]]

remove_file "README.rdoc"
create_file "README.md", "TODO"

gem "rspec-rails", group: [:test, :development]
gem 'haml', version: '>= 4.0.7'

run "bundle install"
git :init

append_file ".gitignore", "config/database.yml"
run "cp config/database.yml config/example_database.yml"
git add: ".", commit: "-m 'initial commit'"

def get_gen_str(model_desc)
  string = model_desc[0]
  model_desc[1].each { |k,v| string << " " << k << ":" << v }
  string
end

article_model = ["Article", {
  "title"        => "string",
  "content"      => "text",
  "published_at" => "datetime",
  "hidden"       => "boolean"
}
]
generate "scaffold", get_gen_str(article_model)

comment_model = ["Comment", {
  "commenter" => "string",
  "content"   => "text",
  "article"   => "references"
}
]

generate "model", get_gen_str(comment_model)

generate "controller", "comments"

route "root to: 'articles\#index'"

rake "db:migrate"

# #
# Take care of Database
#
article_model_file = 'app/models/article.rb'
inject_into_file article_model_file, before: "end" do <<-'RUBY'
  has_many :comments
  RUBY
end

route_config_file = 'config/routes.rb'
inject_into_file route_config_file, after: "resources :articles" do <<-'RUBY'
  do
    resources :comments
  end
  RUBY
end

# 
# Take care of front page
#
remove_file "public/index.html"

app_html_erb = 'app/views/layouts/application.html.erb'
inject_into_file app_html_erb, after: "<body>\n" do <<-'RUBY'
	<div id="container">
	<% flash.each do |name, msg| %>
	      <%= content_tag :div, msg, :id => "flash_#{name}" %>
	<% end %>
	RUBY
end

inject_into_file app_html_erb, after: "<%= yield %>\n" do <<-'RUBY'
	</div>
	RUBY
end

ar_show_html_erb = 'app/views/articles/show.html.erb'
inject_into_file ar_show_html_erb, before: "<%= link_to 'Edit'," do <<-'RUBY'
  <p>
  <%= render @article.comments %>
  </p>

  <p>
  <%= render "comments/form" %>
  </p>

  RUBY
end

#comment_controller_rb = 'app/controllers/comments_controller.rb'
#
#inject_into_file comment_controller_rb, before: "end" do <<-'RUBY'
#
#  def create
#    @article = Article.find(params[:article_id])
#    @comment = @article.comments.create(comment_params)
#    @comment.save
#    redirect_to @article
#  end
#
#  def edit
#    @article = Article.find(params[:article_id])
#    @comment = Comment.find(params[:id])
#  end
#
#  def update
#    @comment = Comment.find(params[:id])
#    @article = Article.find(params[:article_id])
#    if @comment.update(comment_params)
#      redirect_to @article
#    end
#  end
#
#  def destroy
#    @comment.destroy
#  end
#
#  private
#  def comment_params
#    params.require(:comment).permit(:content, :commenter)
#  end
#  RUBY
#end
#
#scaffolds_css = 'app/assets/stylesheets/scaffolds.scss'
#append_file scaffolds_css, <<-'RUBY'
##container {
#	 width: 80%;
#	 margin: 0 auto;
#	 background-color: #FFF;
#	 padding: 20px 40px;
#	 border: solid 1px black;
#	 margin-top: 20px;
#}
#RUBY
#
#bg_color_white = "background-color: #fff;"
#bg_color_blue  = "background-color: #3300CC;"
#
#gsub_file scaffolds_css, bg_color_white, bg_color_blue

# 
# Taking care of testing.
#
#remove_file "db/seeds.rb"

generate "rspec:install"

capify!

app_link = "https://bitbucket.org/tiejli/railsapps/raw"
app_id   = "c434b843903ffe6d6c048fd8c2859e3afbe4109b"
repo = "#{app_link}/#{app_id}"

app_files = ['app/assets/stylesheets/application.scss', 
             'app/views/layouts/application.html.erb',
             'app/controllers/comments_controller.rb',
             'app/views/articles/index.html.erb',
             'app/views/articles/show.html.erb',
             'app/models/article.rb',
             'config/route.rb',
             'db/seeds.rb']

app_files.each do |from_file|
  copy_from_repo 'blogs', from_file, :repo => repo
end

