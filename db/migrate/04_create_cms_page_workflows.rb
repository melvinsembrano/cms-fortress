class CreateCmsPageWorkflows < ActiveRecord::Migration
  def change
    create_table :cms_page_workflows do |t|
      t.integer :cms_page_id
      t.integer :status_id
      t.date :published_date

      t.timestamps
    end
  end
end
