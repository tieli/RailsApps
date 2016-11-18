class File < Thor
  desc "list", "List all files modified recently"
  method_options :force => :boolean, :default => true
  method_options :dest => :string
  def list()
    t0 = File.mtime("Rakefile")
    puts "List recent modified files"
    ['app', 'test', 'lib'].each do |directory|
      Dir.foreach(directory) { |source|
        t = File.mtime(source)
        if (t.min - t0.min > 5)
          puts source
        end
      }
    end
  end
  def copy()
    t0 = File.mtime("Rakefile")
    puts "List recent modified files"
    ['app', 'test', 'lib'].each do |directory|
      Dir.foreach(directory) { |source|
        t = File.mtime(source)
        if (t.min - t0.min > 5)
          destination = "options[:dest]/#{source}"
          FileUtils.rm(destination) if options[:force] && File.exist?(destination)
          if File.exist?(destination)
            puts "Skipping #{destination} because it already exists"
          else
            puts "Copying #{destination}"
            FileUtils.cp_r(source, destination)
          end
        end
      }
    end
  end
end

