class CreateCmsFortressRoleDetails < ActiveRecord::Migration
  def change
    create_table :cms_fortress_role_details do |t|
      t.string :name
      t.string :command
      t.boolean :can_create
      t.boolean :can_update
      t.boolean :can_delete
      t.boolean :can_view
      t.integer :role_id

      t.timestamps
    end
  end
end
