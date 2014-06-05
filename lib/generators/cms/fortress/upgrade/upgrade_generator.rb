class Cms::Fortress::UpgradeGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../../../..', __FILE__)

  def generate_migrations
    rake("cms_fortress_engine:install:migrations")
  end

  def done
    puts "Upgrade complete..."
  end

end
