
namespace :file do
  desc "Find all files modified in the last 100 minutes"
  task :list do
    files = %x{find app -type f  -name "*.rb" -o -name "*.erb" -mmin -120}
    files.each_line do |file|
      puts file
      #file.strip!
      #`bundle exec html2haml #{file} | cat > #{file.gsub(/\.erb$/, ".haml")}`
    end
  end
end
