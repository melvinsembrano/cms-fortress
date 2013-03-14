module Cms
  module Fortress
    module Auth
      def authenticate
        unless current_cms_user
          redirect_to new_cms_user_session_path
        end
      end
    end
  end
end
