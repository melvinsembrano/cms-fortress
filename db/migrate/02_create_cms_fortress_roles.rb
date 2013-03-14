class CreateCmsFortressRoles < ActiveRecord::Migration
  def change
    create_table :cms_fortress_roles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
