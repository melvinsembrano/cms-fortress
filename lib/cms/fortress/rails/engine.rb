module Cms
  module Fortress
    class Engine < ::Rails::Engine

      initializer 'cms-fortress.setup' do |app|
        app.config.to_prepare do
          Devise::SessionsController.layout "cms/fortress/session"
          ApplicationController.helper(Cms::Fortress::ApplicationHelper)

          Cms::ContentController.send(:include, Cms::Fortress::ContentRenderer)
          Cms::Page.send(:include, Cms::Fortress::PageMethods)

        end
        app.config.railties_order = [ :all, ComfortableMexicanSofa::Engine, Cms::Fortress::Engine ]

        ActiveSupport.on_load(:action_controller) do
          include Cms::Fortress::ApplicationControllerMethods
        end
      end

      initializer :assets do |config|
        Rails.application.config.assets.precompile += %w( cms/fortress/admin_overrides.css cms/fortress/session.css )
      end
    end
  end
end

