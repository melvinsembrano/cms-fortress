Rails.application.routes.draw do

  namespace :cms do
    namespace :fortress do
      resources :roles
      resources :users
    end
  end

  get 'cms-admin/settings' => 'cms/fortress/admin#settings', :as => 'settings_cms_admin'
  get 'cms-admin/design' => 'cms/fortress/admin#design', :as => 'design_cms_admin'
  # get 'cms-admin/settings/roles' => 'cms/fortress/admin#roles', :as => 'roles_cms_admin'
  get 'cms-admin/settings/users' => 'cms/fortress/admin#users', :as => 'users_cms_admin'

#  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')

#  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)

=begin
  namespace :cms_admin, :path => ComfortableMexicanSofa.config.admin_route_prefix, :except => :show do
    # resources :roles, :module => 'cms/fortress'
    resources :sites do
    end
  end
=end

end
