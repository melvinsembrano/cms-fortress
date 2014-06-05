require 'generators/cms/comfy/comfy_generator'

class Cms::FortressGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  source_root File.expand_path('../../../../..', __FILE__)
  class_option :comfy, type: :boolean, default: true, description: "Generate Comfy"
  class_option :routes, type: :boolean, default: true, description: "Generate routes"
  class_option :migration, type: :boolean, default: true, description: "Generate migration"
  class_option :devise, type: :boolean, default: true, description: "Generate devise"

  def install_devise
    generate("devise:install") if options.devise?
  end

  def install_comfortable_mexican_sofa
    Cms::ComfyGenerator.start if options.comfy?
  end

  def generate_migrations
    rake("cms_fortress_engine:install:migrations") if options.migration?
  end

  def generate_initialization
    copy_file 'config/initializers/cms_fortress.rb',
      'config/initializers/cms_fortress.rb'
  end

  def generate_routing
    if options.routes?
      route_string = ""
      route_string << "  cms_fortress_routes :path => '/cms-admin'\n"
      route route_string[2..-1]
    end
  end

  def copy_files
    log 'Copying files...'
    files = [
      'config/roles.yml'
    ]
    files.each do |file|
      copy_file file, file
    end
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
