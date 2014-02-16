# Create a generator for an override file for this class
# sample below:
# class Ability < CmsAbility
#
#   def setup_role(role_detail, user)
#     if role_detail.command.eql?('contents.blog')
#       can :manage, Blog
#     else
#       warn "#{ role_detail.command } is not yet handled."
#     end
#   end
#
# end
class CmsAbility
  include CanCan::Ability

  def initialize(user)

    if user && user.role && user.role.role_details
      user.role.role_details.each do |role_detail|
        can :view, role_detail.command if role_detail.can_view?
        can :manage, role_detail.command if role_detail.can_manage?

        if role_detail.can_manage?
          case role_detail.command
            when 'settings.roles'
              can :manage, Cms::Fortress::Role
            when 'settings.sites'
              can :manage, Cms::Site
            when 'settings.users'
              can :manage, Cms::Fortress::User
            when 'contents.pages'
              can :manage, Cms::Page
            when 'contents.files'
              can :manage, Cms::File
            when 'designs.layouts'
              can :manage, Cms::Layout
            when 'designs.snippets'
              can :manage, Cms::Snippet
            else
              setup_role(role_detail, user) if defined?(setup_role)
          end
        end
      end
    end

  end

end
