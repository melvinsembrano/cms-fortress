Rails.application.routes.draw do
  devise_for :cms_users, :class_name => "Cms::Fortress::User", :skip => [:sessions]
  devise_scope :cms_user do
    get 'cms-admin/login' => 'devise/sessions#new', :as => 'new_cms_user_session'
    post 'cms-admin/login' => 'devise/sessions#create', :as => 'cms_user_session'
    delete 'cms-admin/logout' => 'devise/sessions#destroy', :as => 'destroy_cms_user_session'
  end

  get 'cms-admin/admin' => 'cms/fortress/admin#index', :as => 'admin_cms_admin'
  get 'cms-admin/roles' => 'cms/fortress/admin#roles', :as => 'roles_cms_admin'

  namespace :cms_admin, :path => ComfortableMexicanSofa.config.admin_route_prefix, :except => :show do
    # resources :roles, :module => 'cms/fortress'
    resources :sites do
    end
  end

end
