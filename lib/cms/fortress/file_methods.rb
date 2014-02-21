module Cms
  module Fortress
    module FileMethods

      def self.included(base)

        base.class_eval do
          video_mimetypes = %w(mp4 ogg webm).collect{|subtype| "video/#{subtype}"}

          scope :videos, -> { where(:file_content_type => video_mimetypes) }

        end

      end

    end
  end
end
