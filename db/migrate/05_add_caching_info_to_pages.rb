class AddCachingInfoToPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :cached_timeout, :integer, :default => 0
  end
end
