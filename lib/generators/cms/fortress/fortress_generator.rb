
class Cms::FortressGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def install_comfortable_mexican_sofa
    generate("comfy:cms")
  end

  def generate_migrations
    rake("cms_fortress_engine:install:migrations")
  end

  def show_readme
    readme 'README'
  end

end
