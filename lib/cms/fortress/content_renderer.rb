module Cms
  module Fortress
    module ContentRenderer

      def self.included(base)

        base.class_eval do
=begin
          def render_html(status = 200)
            if @cms_layout = @cms_page.layout
              app_layout = (@cms_layout.app_layout.blank? || request.xhr?) ? false : @cms_layout.app_layout
              render :inline => @cms_page.content_cache, :layout => app_layout, :status => status, :content_type => 'text/html'
            else
              render :text => I18n.t('comfy.cms.content.layout_not_found'), :status => 404
            end
          end
=end

          def render_html(status = 200)
            cached_timeout = @cms_page.cached_timeout.to_i

            if cached_timeout > 0
              fresh_when etag: @cms_page, last_modified: @cms_page.updated_at.utc, public: true
              response.cache_control[:max_age] = cached_timeout.seconds
            end

            if @cms_layout = @cms_page.layout

              app_layout = (@cms_layout.app_layout.blank? || request.xhr?) ? false : @cms_layout.app_layout
              render(:inline => @cms_page.content_cache, :layout => app_layout, :status => status, :content_type => 'text/html') unless cached_timeout > 0 && performed?
            else
              render :text => I18n.t('cms.content.layout_not_found'), :status => 404
            end
          end

        end
      end

    end
  end
end
