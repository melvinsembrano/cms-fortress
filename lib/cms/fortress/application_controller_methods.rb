
module Cms
  module Fortress
    module ApplicationControllerMethods
      def after_sign_in_path_for(resource)
        admin_cms_path
      end

      def after_sign_out_path_for(resource_or_scope)
        # request.referrer
        admin_cms_path
      end

      def ability_class
        if File.exist?(File.join(Rails.root, "app", "models", "ability.rb"))
          Ability
        else
          CmsAbility
        end
      end

      def current_ability
         @current_ability ||= ability_class.new(current_cms_fortress_user)
      end

      def self.included(base)
        base.class_eval do

          rescue_from CanCan::AccessDenied do |ex|
            redirect_to cms_fortress_unauthorised_path #, :alert => ex.message
          end

        end
      end

    end
  end
end
