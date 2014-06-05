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

    if user
      if user.type.eql?(:super_user)
        can :manage, :all
      else
        if user.role && user.role.role_details
          user.role.role_details.each do |role_detail|
            can :view, role_detail.command if role_detail.can_view?
            can :manage, role_detail.command if role_detail.can_manage?

            if role_detail.can_manage?
              case role_detail.command
                when 'settings.roles'
                  can :manage, Cms::Fortress::Role, site_id: user.site_id
                when 'settings.sites'
                  can :update, Comfy::Cms::Site, site_id: user.site_id
                when 'settings.users'
                  can :manage, Cms::Fortress::User, site_id: user.site_id
                when 'contents.pages'
                  can :manage, Comfy::Cms::Page, site_id: user.site_id
                when 'contents.files'
                  can :manage, Comfy::Cms::File, site_id: user.site_id
                when 'designs.layouts'
                  can :manage, Comfy::Cms::Layout, site_id: user.site_id
                when 'designs.snippets'
                  can :manage, Comfy::Cms::Snippet, site_id: user.site_id
                else
                  setup_role(role_detail, user) if defined?(setup_role)
              end
            end
          end
        end
      end

    end

  end

end
