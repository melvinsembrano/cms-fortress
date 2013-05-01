
class Cms::FortressGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def generate_migrations
    rake("cms_fortress_engine:install:migrations")
  end

end
