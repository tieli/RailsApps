require "find"

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
  def list()
    t0 = File.mtime("Rakefile")
    puts "List recent modified files"
    ['app', 'test', 'lib'].each do |dir|
      Find.find(dir) { |src|
        t = File.mtime(src)
        #puts src + t.to_s + t0.to_s
        if (t.to_i - t0.to_i > 5 * 60)
          puts src
        end
      }
    end
  end

  desc "copy", "Copy all files modified recently"
  method_options :force => :boolean, :default => true
  method_options :dest => :string
  def copy()
    t0 = File.mtime("Rakefile")
    puts "List recent modified files"
    ['app', 'test', 'lib'].each do |dir|
      Find.find(dir) { |src|
        t = File.mtime(src)
        if (t.to_i - t0.to_i > 5 * 60 )
          dst = "#{options[:dest]}/#{src}"
          FileUtils.rm(dst) if options[:force] && File.exist?(dst)
          if File.exist?(dst)
            puts "Skipping #{dst} because it already exists"
          else
            puts "Copying #{dst}"
            #FileUtils.cp_r(src, options[:dest])
            FileUtils.cp(src, dst)
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
