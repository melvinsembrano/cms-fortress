class Cms::Fortress::Role < ActiveRecord::Base
  set_table_name :cms_fortress_roles
  attr_accessible :description, :name
  has_many :role_users
  has_many :users, :through => :role_users
end
