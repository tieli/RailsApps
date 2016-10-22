
namespace :erb do
  namespace :to do
    desc "Convert erb to haml"
    task :haml do
      files = `find . -iname *.html.erb`
      files.each_line do |file|
        puts file
        file.strip!
        `bundle exec html2haml #{file} | cat > #{file.gsub(/\.erb$/, ".haml")}`
      end
    end
  end
end
