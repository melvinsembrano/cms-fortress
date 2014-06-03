ActiveRecord::Schema.define do
  self.verbose = false

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

    t.timestamps
  end

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

  create_table :cms_fortress_roles do |t|
    t.string :name
    t.text :description

    t.timestamps
  end

  create_table :cms_page_workflows do |t|
    t.integer :cms_page_id
    t.integer :status_id
    t.date :published_date

    t.timestamps
  end
end
