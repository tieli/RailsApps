class Setup < Thor

  desc "config", "Copy configuration files"
  method_options :force => :boolean
  def config(name = "*")
    puts "running config"
    Dir['config/examples/#{name}'].each do |source|
      destination = "config/#{File.basename(source)}"
      FileUtils.rm(destination) if options[:force] && File.exist?(destination)
      if File.exist?(destination)
        puts "Skipping #{destination} because it already exists"
      else
        puts "Generating #{destination}"
        FileUtils.cp(source, destination)
      end
    end
  end

  desc "populate", "generate records"
  method_options :count => :numeric
  def populate
    require File.expand_path("config/environment.rb")
    options[:count].times do |num|
      puts "Generating article #{num}"
      Article.create!(:name => "Article #{num}")
    end
  end

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

  desc "copy", "Copy all files modified recently"
  method_options :force => :boolean, :default => true
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

  desc "test", "Testing thor command"
  def test()
    puts "TEsting"
    if File.exist?("Rakefile")
      puts File.mtime("Rakefile")
    end
  end

end
