Rails.application.routes.draw do
  devise_for :cms_users, :class_name => "Cms::Fortress::User", :skip => [:sessions]
  devise_scope :cms_user do
    get 'cms-admin/login' => 'devise/sessions#new', :as => 'new_user_admin_session'
    post 'cms-admin/login' => 'devise/sessions#create', :as => 'cms_user_session'
    delete 'cms-admin/logout' => 'devise/sessions#destroy', :as => 'destroy_cms_user_session'
  end

end
