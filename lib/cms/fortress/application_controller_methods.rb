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
    end
  end
end
