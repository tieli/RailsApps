
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
generate "rspec:install"

remove_file "public/index.html"

main_file = 'app/views/layouts/application.html.erb'
inject_into_file main_file, after: "<body>\n" do <<-'RUBY'
	<div id="container">
		<% flash.each do |name, msg| %>
		<%= content_tag :div, msg, :id => "flash_#{name}" %>
        <% end %>
	RUBY
end

inject_into_file main_file, after: "<%= yield %>\n" do <<-'RUBY'
	</div>
	RUBY
end

git :init
append_file ".gitignore", "config/database.yml"
run "cp config/database.yml config/example_database.yml"
git add: ".", commit: "-m 'initial commit'"

generate "scaffold", "articles name:string content:text"
route "root to: 'articles\#index'"

rake "db:migrate"

scaffolds_css = 'app/assets/stylesheets/scaffolds.css.scss'
append_file scaffolds_css, <<-'RUBY'
#container {
	 width: 80%;
	 margin: 0 auto;
	 background-color: #FFF;
	 padding: 20px 40px;
	 border: solid 1px black;
	 margin-top: 20px;
}
RUBY

bg_color_white = "background-color: #fff;"
bg_color_blue  = "background-color: #3300CC;"

gsub_file scaffolds_css, bg_color_white, bg_color_blue

capify!
