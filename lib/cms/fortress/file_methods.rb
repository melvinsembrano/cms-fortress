module Cms
  module Fortress
    module FileMethods

      def self.included(base)

        base.class_eval do
          image_mimetypes = %w(gif jpeg pjpeg png tiff).collect{|subtype| "image/#{subtype}"}
          video_mimetypes = %w(mp4 ogg webm).collect{|subtype| "video/#{subtype}"}

          scope :videos, -> { where(:file_content_type => video_mimetypes) }
          scope :others,  -> { where('file_content_type NOT IN (?)', image_mimetypes + video_mimetypes) }

        end

      end

    end
  end
end
