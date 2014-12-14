require 'comfortable_mexican_sofa'
require 'devise'
require 'cancan'
require 'aasm'
require 'tinymce-rails'
require 'tinymce-rails-langs'

require_relative 'comfortable_mexican_sofa/fixture/page'

require_relative 'cms/fortress/application_controller_methods'
require_relative 'cms/fortress/sites_controller_methods'
require_relative 'cms/fortress/pages_controller_methods'
require_relative 'cms/fortress/page_methods'
require_relative 'cms/fortress/file_methods'
require_relative 'cms/fortress/site_methods'
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
          {:name => 'pages', :title => 'comfy.admin.cms.base.pages',
           :path => 'comfy_admin_cms_site_pages_path(@site) if @site && !@site.new_record?'},
          {:name => 'files', :title => 'comfy.admin.cms.base.files',
          :path => 'comfy_admin_cms_site_files_path(@site) if @site && !@site.new_record?'}
        ]
        @design_resources = [
          {:name => 'layouts', :title => 'comfy.admin.cms.base.layouts',
           :path => 'comfy_admin_cms_site_layouts_path(@site) if @site && !@site.new_record?'
          },
          {:name => 'snippets', :title => 'comfy.admin.cms.base.snippets',
          :path => 'comfy_admin_cms_site_snippets_path(@site) if @site && !@site.new_record?'}
        ]
        @settings_resources = [
          {name: 'dropdown-header', title: "cms.fortress.admin.super_user.menu_header", super_user: true},
          {:name => 'sites', :title => 'comfy.admin.cms.base.sites',
          :path => 'comfy_admin_cms_sites_path', :super_user => true},
          {:name => 'super_users', :title => 'cms.fortress.admin.super_user.title',
          :path => 'super_cms_fortress_users_path', :super_user => true},
          {name: 'divider', super_user: true},
          {name: 'dropdown-header', title: "cms.fortress.admin.sites.menu_header"},
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
