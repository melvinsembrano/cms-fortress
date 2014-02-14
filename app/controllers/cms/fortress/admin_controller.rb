module Cms
  module Fortress
    class AdminController < Admin::Cms::BaseController

      def roles
        @roles = Role.all
      end



    end
  end
end
