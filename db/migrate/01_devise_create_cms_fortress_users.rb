class DeviseCreateCmsFortressUsers < ActiveRecord::Migration

  # move creation of default user to the 08 migration
  # def migrate(direction)
  #   super

  #   # Create default cms-admin user
  #   Cms::Fortress::User.create!(:email => 'admin@cmsfortress.com', :password => '1234qwer', :password_confirmation => '1234qwer', :role_id => 1) if direction == :up
  # end

  def change
    create_table(:cms_fortress_users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      t.integer :role_id

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :first_name, :last_name

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token


      t.timestamps
    end

    add_index :cms_fortress_users, :email,                :unique => true
    add_index :cms_fortress_users, :reset_password_token, :unique => true
    # add_index :cms_fortress_users, :confirmation_token,   :unique => true
    # add_index :cms_fortress_users, :unlock_token,         :unique => true
    # add_index :cms_fortress_users, :authentication_token, :unique => true
  end
end
