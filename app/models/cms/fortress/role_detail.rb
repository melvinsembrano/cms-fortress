class Cms::Fortress::RoleDetail < ActiveRecord::Base
  self.table_name = "cms_fortress_role_details"

  belongs_to :role

  def can_manage?
    can_create?
  end

end
