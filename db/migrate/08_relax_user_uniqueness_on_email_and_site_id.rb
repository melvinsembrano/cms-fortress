class RelaxUserUniquenessOnEmailAndSiteId < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create default cms-admin user
    Cms::Fortress::User.create!(:email => 'admin@cmsfortress.com', :password => '1234qwer', :password_confirmation => '1234qwer', :role_id => 1) if direction == :up
  end

  def change
    remove_index :cms_fortress_users, :email
    add_index :cms_fortress_users, [:email, :site_id], :unique => true
  end
end
