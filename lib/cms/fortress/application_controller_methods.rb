
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
        if defined?(Ability)  #File.exist?(File.join(Rails.root, "app", "models", "ability.rb"))
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
            # if cannot view page check if can on files
            if controller_name.eql?('pages')
              if can? :view, Cms::File
                redirect_to admin_cms_site_files_path
              else
              redirect_to cms_fortress_unauthorised_path
              end
            elsif controller_name.eql?('layouts')
              if can? :view, Cms::Snippet
                redirect_to admin_cms_site_snippets_path
              else
              redirect_to cms_fortress_unauthorised_path
              end
            elsif controller_name.eql?('sites')
              if can? :view, Cms::Fortress::Role
                redirect_to cms_fortress_roles_path
              else
              redirect_to cms_fortress_unauthorised_path
              end
            else
              redirect_to cms_fortress_unauthorised_path #, :alert => ex.message
            end
          end

        end
      end

    end
  end
end
