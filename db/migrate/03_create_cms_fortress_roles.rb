class CreateCmsFortressRoles < ActiveRecord::Migration

  def migrate(direction)
    super

    # Create default users
    {
      :administrator => {

      },
      :author => {

      },
      :contributor => {

      }
    }.each do |k, roles|
      role = Cms::Fortress::Role.create!(:name => k.to_s.humanize, :description => k.to_s.humanize)
      role.load_defaults
      role.save
    end
  end


  def change
    create_table :cms_fortress_roles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
