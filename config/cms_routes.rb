Cms::Fortress::Application.routes.draw do

  cms_fortress_routes :path => '/cms-admin'
  comfy_route :cms_admin, :path => '/cms-admin'

  comfy_route :cms, :path => '/', :sitemap => false
end
