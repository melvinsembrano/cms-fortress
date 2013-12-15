class ActionDispatch::Routing::Mapper

  def cms_fortress_routes(options = {})
    path = options[:path] || "cms-admin"

    devise_for "cms/fortress/users", :path => path, :path_names => {
      :sign_in => 'login', :sign_out => 'logout'
    }

    scope path, module: 'cms/fortress' do
      resources :roles, :as => 'cms_fortress_roles' do
        member do
          post :refresh
        end
      end
      resources :users, :as => 'cms_fortress_users'

      get 'settings' => 'admin#settings', :as => 'cms_fortress_settings'
      get 'design' => 'admin#design', :as => 'cms_fortress_design'
      get 'contents' => 'admin#contents', :as => 'cms_fortress_contents'
      get 'settings/users' => 'admin#users', :as => 'cms_fortress_user_settings'
      get 'unauthorised' => 'admin#unauthorised', :as => 'cms_fortress_unauthorised'

    end

  end
end
