module Cms
  module Fortress
    class AdminController < Admin::Cms::BaseController

      def roles
        @roles = Role.all
      end

      def images
        @files = Cms::File.images
        respond_to do |format|
          format.html { render partial: 'cms/fortress/shared/media_items', locals: {media: @files} }
          format.json { render json: @files }
        end
      end

    end
  end
end
