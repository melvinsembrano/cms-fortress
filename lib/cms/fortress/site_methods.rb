require 'active_support/concern'

module Cms
  module Fortress
    module SiteMethods
      extend ActiveSupport::Concern

      included do
        after_create :generate_defaults

        has_many :users, class_name: "Cms::Fortress::User", foreign_key: :site_id
        has_many :roles, class_name: "Cms::Fortress::Role", foreign_key: :site_id
        has_many :role_details, class_name: "Cms::Fortress::RoleDetail", foreign_key: :site_id
      end

      # generate default roles specific for the site
      def generate_defaults
        #TODO: implement I18n below
        role = Cms::Fortress::Role.create!(:site_id => id, :name => "#{label} Administrator", :description => "#{ label } administrator users")
        role.load_defaults
        role.save
      end

      module ClassMethods

      end
    end
  end
end
