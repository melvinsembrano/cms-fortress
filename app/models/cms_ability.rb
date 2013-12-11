class CmsAbility
  include CanCan::Ability

  def initialize(user)

    if user && user.role && user.role.role_details
      user.role.role_details.each do |role|
        can :view, role.command if role.can_view?
        can :manage, role.command if role.can_create?

        if role.can_create?
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
          end
        end
      end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
