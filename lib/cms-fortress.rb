require 'comfortable_mexican_sofa'
require 'devise'
require 'cancan'
require 'tinymce-rails'

require_relative 'comfortable_mexican_sofa/fixture/page'

require_relative 'cms/fortress/application_controller_methods'
require_relative 'cms/fortress/page_methods'
require_relative 'cms/fortress/rails/engine'
require_relative 'cms/fortress/auth'
require_relative 'cms/fortress/content_renderer'
require_relative 'cms/fortress/comfortable_mexican_sofa'
require_relative 'cms/fortress/devise'
require_relative 'cms/fortress/routing'
require_relative '../app/models/cms_ability'

module Cms
  module Fortress
    class Configuration

      attr_accessor :content_resources
      attr_accessor :design_resources
      attr_accessor :settings_resources
      attr_accessor :enable_page_workflow
      attr_accessor :enable_page_caching
      attr_accessor :theme

      def initialize
        self.class.send(:include, Rails.application.routes.url_helpers)
        @theme = :default
        @enable_page_workflow = true
        @enable_page_caching = true
        @content_resources = [
          {:name => 'pages', :title => 'admin.cms.base.pages',
           :path => 'admin_cms_site_pages_path(@site) if @site && !@site.new_record?'},
          {:name => 'files', :title => 'admin.cms.base.files',
          :path => 'admin_cms_site_files_path(@site) if @site && !@site.new_record?'}
        ]
        @design_resources = [
          {:name => 'layouts', :title => 'admin.cms.base.layouts',
           :path => 'admin_cms_site_layouts_path(@site) if @site && !@site.new_record?'
          },
          {:name => 'snippets', :title => 'admin.cms.base.snippets',
          :path => 'admin_cms_site_snippets_path(@site) if @site && !@site.new_record?'}
        ]
        @settings_resources = [
          {:name => 'sites', :title => 'admin.cms.base.sites',
          :path => 'admin_cms_sites_path'},
          {:name => 'roles', :title => 'cms.fortress.roles.title',
          :path => 'cms_fortress_roles_path'},
          {:name => 'users', :title => 'cms.fortress.users.title',
          :path => 'cms_fortress_users_path'}
        ]
      end

    end

    class << self
      def configure
        yield configuration
      end

      def configuration
        @configuration ||= Configuration.new
      end

    end

  end
end
