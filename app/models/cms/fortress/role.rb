class Cms::Fortress::Role < ActiveRecord::Base
  # set_table_name :cms_fortress_roles
  self.table_name = "cms_fortress_roles"
  # attr_accessible :description, :name
  has_many :users
  has_many :role_details
  accepts_nested_attributes_for :role_details, allow_destroy: true

  def load_defaults
    # load user custom roles
    if File.exist?(file = File.join(Rails.root, "config", "roles.yml"))
      load_from_file(file)
    end

    file = File.expand_path(File.join(File.dirname(__FILE__), "../../../../", "config", "roles.yml"))
    load_from_file(file)
  end

  private

  def load_from_file(file)
    data = YAML.load_file(file)
    data.each do |k,v|
      v.each do |m|
        description = m.split('.').map(&:humanize).join(' - ')
        role_details.build(
          :name       => description,
          :command    => "#{k}.#{m}",
          :can_create => true,
          :can_update => true,
          :can_delete => true,
          :can_view   => true
        ) unless role_details.map(&:command).include?("#{k}.#{m}")
      end
    end

  end
end
