class Cms::Fortress::RoleUser < ActiveRecord::Base
  set_table_name :cms_fortress_role_users
  attr_accessible :role_id, :user_id
  belongs_to :role
  belongs_to :user

end
