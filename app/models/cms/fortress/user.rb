class Cms::Fortress::User < ActiveRecord::Base
  # set_table_name :cms_fortress_users
  self.table_name = "cms_fortress_users"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :role

end
