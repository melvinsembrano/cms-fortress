class ActionDispatch::Routing::Mapper

  def cms_fortress_routes(options = {})
    path = options[:path] || "cms-admin"

    devise_for "cms/fortress/users",
      :path => path,
      :path_names => {
        :sign_in => 'login', :sign_out => 'logout'
      },
      :controllers => {
        :sessions => 'cms/fortress/users/sessions',
        :passwords => 'cms/fortress/users/passwords'
      }

    scope path, module: 'cms/fortress' do
      resources :roles, :as => 'cms_fortress_roles' do
        member do
          post :refresh
        end
      end

      resources :users, :except => :show, :as => 'cms_fortress_users' do
        collection do
          get :super
          get "super/new", action: "new_super"
        end
      end

      get 'settings/users' => 'admin#users', as: 'cms_fortress_user_settings'
      get 'unauthorised' => 'admin#unauthorised', as: 'cms_fortress_unauthorised'

      get 'sites/:site_id/files/images' => 'admin#images', as: 'cms_fortress_files_images'
      get 'sites/:site_id/files/videos' => 'admin#videos', as: 'cms_fortress_files_videos'
      get 'sites/:site_id/files/others' => 'admin#other_files', as: 'cms_fortress_files_others'

      # Site Resource routes
      get 'site/dashboard' => 'admin#dashboard', as: 'dashboard_site'
    end

  end
end
