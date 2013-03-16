module Cms
  module Fortress
    class AdminController < CmsAdmin::BaseController

      def index

      end

      def roles
        @roles = Role.all
      end



    end
  end
end
