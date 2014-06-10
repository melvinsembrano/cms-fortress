class IntegrateWorkflowIntoCmsPages < ActiveRecord::Migration
  class Cms::PageWorkflow < ActiveRecord::Base
    self.table_name = 'cms_page_workflows'
    belongs_to :page, :class_name => 'Comfy::Cms::Page', :foreign_key => 'cms_page_id'
  end

  def change

    add_column :comfy_cms_pages, :aasm_state, :string, default: 'new'
    add_column :comfy_cms_pages, :published_date, :date

    Cms::PageWorkflow.all.each do |workflow|
      workflow.page.aasm_state = case workflow.status_id.to_i
        when 0
          'drafted'
        when 1
          'reviewed'
        when 2
          'scheduled'
        when 3
          'published'
        else
          'drafted'
                                 end
      workflow.page.published_date = workflow.published_date
      workflow.save!
    end

    drop_table :cms_page_workflows
  end
end
