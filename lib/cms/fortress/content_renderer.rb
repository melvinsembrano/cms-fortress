module Cms
  module Fortress
    module ContentRenderer

      def self.included(base)

        base.class_eval do

          def render_html(status = 200)

            fresh_when etag: @cms_page, last_modified: @cms_page.updated_at.utc, public: true

            if @cms_layout = @cms_page.layout

              #TODO: put the caching config in the page
              response.cache_control[:max_age] = 5.minutes

              app_layout = (@cms_layout.app_layout.blank? || request.xhr?) ? false : @cms_layout.app_layout
              render(:inline => @cms_page.content, :layout => app_layout, :status => status, :content_type => 'text/html') unless performed?
            else
              render :text => I18n.t('cms.content.layout_not_found'), :status => 404
            end
          end

        end
      end

    end
  end
end
