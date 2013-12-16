class AddCachingInfoToPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :cached_timeout, :integer, :default => 0
  end
end
