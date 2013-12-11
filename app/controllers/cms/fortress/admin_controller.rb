module Cms
  module Fortress
    class AdminController < Admin::Cms::BaseController

      def designs

      end

      def settings

      end

      def contents

      end

      def index

      end

      def roles
        @roles = Role.all
      end



    end
  end
end
