module Cms
  module Fortress
    class Engine < ::Rails::Engine

      initializer 'cms-fortress.setup' do |app|
        app.config.to_prepare do
          # Devise::SessionsController.layout "cms/fortress/session"
          ApplicationController.helper(Cms::Fortress::ApplicationHelper)

          Cms::ContentController.send(:include, Cms::Fortress::ContentRenderer)
          Cms::Page.send(:include, Cms::Fortress::PageMethods)
          Cms::File.send(:include, Cms::Fortress::FileMethods)

          # Insert Roles
          Admin::Cms::SitesController.class_eval do
            before_action do
              authorize! :manage, Cms::Site
            end
          end
          Admin::Cms::LayoutsController.class_eval do
            before_action do
              authorize! :manage, Cms::Layout
            end
          end
          Admin::Cms::SnippetsController.class_eval do
            before_action do
              authorize! :manage, Cms::Snippet
            end
          end
          Admin::Cms::PagesController.class_eval do
            before_action do
              authorize! :manage, Cms::Page
            end
          end
          Admin::Cms::FilesController.class_eval do
            before_action do
              authorize! :manage, Cms::File
            end
          end

        end
        app.config.railties_order = [ :all, ComfortableMexicanSofa::Engine, Cms::Fortress::Engine ]

        ActiveSupport.on_load(:action_controller) do
          include Cms::Fortress::ApplicationControllerMethods
        end
      end

      initializer :assets do |config|
        Rails.application.config.assets.precompile += %w( cms/fortress/admin_overrides.css cms/fortress/session.css cms/fortress/themes/wide.css cms/fortress/themes/wide.js)
      end
    end
  end
end

