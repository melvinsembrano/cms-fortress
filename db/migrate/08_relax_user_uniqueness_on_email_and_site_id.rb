class RelaxUserUniquenessOnEmailAndSiteId < ActiveRecord::Migration
  def change
    remove_index :cms_fortress_users, :email
    add_index :cms_fortress_users, [:email, :site_id], :unique => true
  end
end
