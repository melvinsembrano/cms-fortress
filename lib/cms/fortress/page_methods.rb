module Cms
  module Fortress
    module PageMethods

      def self.included(base)

        base.class_eval do
          has_one :page_workflow, :class_name => "Cms::PageWorkflow", :foreign_key => 'cms_page_id'
          accepts_nested_attributes_for :page_workflow

        end

      end

    end
  end
end
