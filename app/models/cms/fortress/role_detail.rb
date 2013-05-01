class Cms::Fortress::RoleDetail < ActiveRecord::Base
  set_table_name :cms_fortress_role_details
  attr_accessible :command, :can_create, :can_delete, :name, :can_update, :can_view
  belongs_to :role

end
