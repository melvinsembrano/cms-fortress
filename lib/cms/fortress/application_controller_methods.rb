module Cms
  module Fortress
    module ApplicationControllerMethods
      def after_sign_in_path_for(resource)
        cms_admin_path
      end

      def after_sign_out_path_for(resource_or_scope)
        # request.referrer
        cms_admin_path
      end
    end
  end
end
