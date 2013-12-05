module Cms
  module Fortress
    module Auth
      def authenticate
        unless current_cms_fortress_user
          redirect_to new_cms_fortress_user_session_path
        end
      end
    end
  end
end
