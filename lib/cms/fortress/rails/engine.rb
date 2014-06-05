module Cms
  module Fortress
    class Engine < ::Rails::Engine

      initializer 'cms-fortress.setup' do |app|
        app.config.to_prepare do
          # Devise::SessionsController.layout "cms/fortress/session"
          ApplicationController.helper(Cms::Fortress::ApplicationHelper)

          Sprockets::Context.send :include, Cms::Fortress::SprocketHelper

          Comfy::Cms::ContentController.send(:include, Cms::Fortress::ContentRenderer)
          Comfy::Cms::Page.send(:include, Cms::Fortress::PageMethods)
          Comfy::Cms::File.send(:include, Cms::Fortress::FileMethods)
          Comfy::Cms::Site.send(:include, Cms::Fortress::SiteMethods)


          Comfy::Admin::Cms::BaseController.class_eval do
            before_action do
              if current_cms_fortress_user && current_cms_fortress_user.type.eql?(:site_user)
                @site = current_cms_fortress_user.site
                session[:site_id] = @site.id if @site
              end
            end
          end

          # Insert Roles
          Comfy::Admin::Cms::SitesController.class_eval do
            before_action do
              authorize! :manage, Comfy::Cms::Site
            end
            before_action only: [:new, :create] do
              raise CanCan::AccessDenied.new("Youa are not allowed to create a site.") unless current_cms_fortress_user.type.eql?(:super_user)
            end
          end
          Comfy::Admin::Cms::LayoutsController.class_eval do
            before_action do
              authorize! :manage, Comfy::Cms::Layout
            end
          end
          Comfy::Admin::Cms::SnippetsController.class_eval do
            before_action do
              authorize! :manage, Comfy::Cms::Snippet
            end
          end
          Comfy::Admin::Cms::PagesController.class_eval do
            before_action do
              authorize! :manage, Comfy::Cms::Page
            end
          end
          Comfy::Admin::Cms::FilesController.class_eval do
            before_action do
              authorize! :manage, Comfy::Cms::File
            end
          end

        end
        app.config.railties_order = [ :all, ComfortableMexicanSofa::Engine, Cms::Fortress::Engine ]

        ActiveSupport.on_load(:action_controller) do
          include Cms::Fortress::ApplicationControllerMethods
        end
      end

      initializer :assets do |config|
        Rails.application.config.assets.precompile += %w( cms/fortress/admin_overrides.css cms/fortress/session.css cms/fortress/themes/wide.css cms/fortress/themes/wide.js cms/fortress/media.js html5shiv.js cms/fortress/cms_fortress.js)
      end
    end
  end
end

