class Cms::Fortress::User < ActiveRecord::Base
  # set_table_name :cms_fortress_users
  self.table_name = "cms_fortress_users"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # manually add :validatable validations because uniqueness does not include :site_id
  validates_presence_of   :email, if: :email_required?
  validates_uniqueness_of :email, scope: :site_id, allow_blank: true, if: :email_changed?
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?
  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: Devise.password_length, allow_blank: true
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :timeoutable,
         :authentication_keys => [:email, :site_id]

  belongs_to :role
  belongs_to :site, class_name: "Comfy::Cms::Site", foreign_key: :site_id

  scope :all_super, -> { where(type_id: 1) }

  def self.types
    {
      1 => :super_user,
      2 => :site_user
    }
  end

  def self.find_for_authentication(warden_conditions)
    where(:email => warden_conditions[:email], :site_id => warden_conditions[:site_id]).first || where(:email => warden_conditions[:email]).first
  end

  def type
    self.class.types[type_id]
  end

  def display_name
    "#{ email } (#{ type.to_s.titleize })"
  end

protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end

end
