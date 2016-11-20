require "find"

namespace :file do

  desc "Find all files modified in the last 100 minutes"
  task :copy do
    #files = %x{find app -type f  -name "*.rb" -o -name "*.erb" -mmin -120}
    puts "List recent modified files"
    t0 = File.mtime(Rails.root.join("Rakefile"))
    ['app', 'test', 'lib'].each do |dir|
      Find.find(dir) { |src|
        file = Rails.root.join(src)
        t = File.mtime(file)
        if (t.min - t0.min > 5)
          dst = ENV['DST']
          FileUtils.rm(dst) if File.exist?(dst)
          if File.exist?(dst)
            puts "Skipping #{dst} because it already exists"
          else
            puts "Copying #{src} to #{dst}"
            FileUtils.cp_r(src, dst)
          end
        end
      }
    end
  end

  desc "List all files modified recently"
  task :list do
    t0 = File.mtime(Rails.root.join("Rakefile"))
    puts "List recent modified files"
    ['app', 'test', 'lib'].each do |dir|
      Find.find(dir) { |src|
        file = Rails.root.join(src)
        t = File.mtime(file)
        if (t.min - t0.min > 5)
          puts src
        end
      }
    end
  end

end
