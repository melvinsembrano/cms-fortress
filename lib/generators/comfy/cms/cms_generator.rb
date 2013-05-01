module Comfy
  module Generators
    class CmsGenerator < Rails::Generators::Base

      require 'rails/generators/active_record'
      include Rails::Generators::Migration
      include Thor::Actions

      spec = Gem::Specification.find_by_name("comfortable_mexican_sofa")
      source_root spec.gem_dir  # File.expand_path('../../../../..', __FILE__)

      def generate_migration
        destination   = File.expand_path('db/migrate/01_create_cms.rb', self.destination_root)
        migration_dir = File.dirname(destination)
        destination   = self.class.migration_exists?(migration_dir, 'create_cms')

        if destination
          puts "\e[0m\e[31mFound existing cms_create.rb migration. Remove it if you want to regenerate.\e[0m"
        else
          migration_template 'db/migrate/01_create_cms.rb', 'db/migrate/create_cms.rb'
        end
      end

      def generate_initialization
        copy_file 'config/initializers/comfortable_mexican_sofa.rb',
          'config/initializers/comfortable_mexican_sofa.rb'
      end

=begin
      def generate_routing
        route "
  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')
  
  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)"
      end
=end

      def generate_cms_seeds
        directory 'db/cms_fixtures', 'db/cms_fixtures'
      end

=begin
      def show_readme
        readme 'lib/generators/comfy/cms/README'
      end
=end
      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end
      
    end
  end
end

