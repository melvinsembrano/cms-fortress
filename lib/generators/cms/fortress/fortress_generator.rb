
class Cms::FortressGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  source_root File.expand_path('../../../../..', __FILE__)

  def install_devise
    generate("devise:install")
  end

  def install_comfortable_mexican_sofa
    generate("comfy:cms")
  end

  def generate_migrations
    rake("cms_fortress_engine:install:migrations")
  end
=begin
  def generate_assets
    directory 'app/assets/javascripts/cms/fortress',
      'app/assets/javascripts/cms/fortress'

    directory 'app/assets/stylesheets/cms/fortress',
      'app/assets/stylesheets/cms/fortress'
  end
=end
  def show_readme
    readme 'lib/generators/cms/fortress/templates/README'
  end

end
