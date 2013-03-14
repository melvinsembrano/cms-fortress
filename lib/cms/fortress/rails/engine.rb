module Cms
  module Fortress
    class Engine < ::Rails::Engine

      initializer 'cms-fortress.setup' do |app|
        app.config.to_prepare do
          Devise::SessionsController.layout "cms/fortress/session"
        end
        app.config.railties_order = [ :all, ComfortableMexicanSofa::Engine, Cms::Fortress::Engine ]
      end
    end
  end
end

