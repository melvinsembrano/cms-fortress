class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :cms_fortress_users, :type_id, :integer
    add_column :cms_fortress_users, :site_id, :integer
    add_column :cms_fortress_roles, :site_id, :integer
    add_column :cms_fortress_role_details, :site_id, :integer
    add_column :cms_page_workflows, :site_id, :integer

    Cms::Fortress::User.update_all(type_id: 1)
  end
end
