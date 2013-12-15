class Cms::Fortress::RoleDetail < ActiveRecord::Base
  self.table_name = "cms_fortress_role_details"

  belongs_to :role

  default_scope { order(:command) }

  def can_manage?
    can_create?
  end

end
