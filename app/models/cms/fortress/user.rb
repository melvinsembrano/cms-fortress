class Cms::Fortress::User < ActiveRecord::Base
  # set_table_name :cms_fortress_users
  self.table_name = "cms_fortress_users"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :role
  belongs_to :site, class_name: "Comfy::Cms::Site", foreign_key: :site_id

  def self.types
    {
      1 => :super_user,
      2 => :site_user
    }
  end

  def type
    self.class.types[type_id]
  end

  def display_name
    "#{ email } (#{ type.to_s.titleize })"
  end
end
