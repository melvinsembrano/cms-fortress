require 'rails/generators'
require 'generators/comfy/cms/cms_generator'

class Cms::ComfyGenerator < Comfy::Generators::CmsGenerator
  spec = Gem::Specification.find_by_name("comfortable_mexican_sofa")
  source_root spec.gem_dir # File.expand_path('../../../../..', __FILE__)

  def generate_routing
    route_string  = "  comfy_route :cms_admin, :path => '/cms-admin'\n\n"
    route_string << "  # Make sure this routeset is defined last\n"
    route_string << "  comfy_route :cms, :path => '/', :sitemap => false\n"
    route route_string[2..-1]
  end

  def show_readme

  end
end
