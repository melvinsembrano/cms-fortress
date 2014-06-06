require 'active_support/concern'
module Cms
  module Fortress
    module SiteControllerMethods
      extend ActiveSupport::Concern

      included do
        before_action do
          authorize! :manage, Comfy::Cms::Site
        end
        before_action only: [:new, :create] do
          raise CanCan::AccessDenied.new("You are not allowed to create a site.") unless current_cms_fortress_user.type.eql?(:super_user)
        end
      end

      module ClassMethods

      end

    end
  end
end
