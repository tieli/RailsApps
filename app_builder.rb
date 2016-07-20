class AppBuilder < Rails::AppBuilder
  def readme
    create_file "README.md", "TODO from App Builder"
  end

  def config
    create_file "config/initializers/bullet.rb", <<-BULLET
    if defined? Bullet
      Bullet.enable = true
      Bullet.alert  = true
    end
    BULLET
  end
end

