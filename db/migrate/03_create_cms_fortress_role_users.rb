class CreateCmsFortressRoleUsers < ActiveRecord::Migration
  def change
    create_table :cms_fortress_role_users do |t|
      t.integer :role_id
      t.integer :user_id

      t.timestamps
    end
  end
end
