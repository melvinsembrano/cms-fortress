class CmsAbility
  include CanCan::Ability

  def initialize(user)

    if user && user.role && user.role.role_details
      user.role.role_details.each do |role|
        can :view, role.command if role.can_view?
        can :manage, role.command if role.can_manage?

        if role.can_manage?
          if role.command.eql?("settings.roles") 
            can :manage, Cms::Fortress::Role
          elsif role.command.eql?("settings.sites")
            can :manage, Cms::Site
          elsif role.command.eql?("settings.users")
            can :manage, Cms::Fortress::User
          elsif role.command.eql?("contents.pages")
            can :manage, Cms::Page
          elsif role.command.eql?("contents.files")
            can :manage, Cms::File
          elsif role.command.eql?("designs.layouts")
            can :manage, Cms::Layout
          elsif role.command.eql?("designs.snippets")
            can :manage, Cms::Snippet
          else
            setup_role(role)
          end
        end
      end
    end

  end

  # override this if you have custom role assignment
  def setup_role(role)

  end


end
