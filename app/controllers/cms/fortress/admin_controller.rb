module Cms
  module Fortress
    class AdminController < Admin::Cms::BaseController

      def roles
        @roles = Role.all
      end

      def images
        @files = Cms::File.images
        respond_to do |format|
          format.html { render partial: 'cms/fortress/shared/media_items', locals: {media: @files, type: :image} }
          format.json { render json: @files }
        end
      end

      def videos
        @files = Cms::File.videos
        respond_to do |format|
          format.html { render partial: 'cms/fortress/shared/media_items', locals: {media: @files, type: :video} }
          format.json { render json: @files }
        end
      end

      def other_files
        @files = Cms::File.others.map {|f| {title: f.label, value: f.file.url}}
        respond_to do |format|
          format.html { render partial: 'cms/fortress/shared/media_items', locals: {media: @files, type: :others} }
          format.json { render json: @files }
        end
      end


    end
  end
end
