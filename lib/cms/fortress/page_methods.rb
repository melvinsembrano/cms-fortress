module Cms
  module Fortress
    module PageMethods

      def self.included(base)

        base.class_eval do
          has_one :page_workflow, :class_name => "Cms::PageWorkflow", :foreign_key => 'cms_page_id'
          accepts_nested_attributes_for :page_workflow

          scope :drafts, -> { joins(:page_workflow).where(cms_page_workflows: {status_id: 0}) }
          scope :reviewed, -> { joins(:page_workflow).where(cms_page_workflows: {status_id: 1}) }

        end

      end

    end
  end
end
