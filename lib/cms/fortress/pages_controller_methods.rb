module Cms
  module Fortress
    module PagesControllerMethods

      def transit_to_state
        @page.send(params.fetch(:transition)) if params[:transition].present?
      end

      def self.included(base)
        base.class_eval do
          before_action :transit_to_state, only: [:create, :update]
        end
      end

    end
  end
end
