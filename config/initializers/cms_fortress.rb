Cms::Fortress.configure do |config|
  # comment the line below if you want to use the default layout
  config.theme = :wide

  # Turn off page workflow options
  # config.enable_page_workflow = false
  # Turn off page caching options
  # config.enable_page_caching = false

  # Add new resource to contents
  # config.content_resources << {
  #   name: 'my_role_detail',
  #   title: 'i18n.label.title', # this is passed to the t() function - can be plain text
  #   path:  'admin_my_role_details_path'
  # }

  # Add new resource to settings
  # config.settings_resources << {
  #   name: 'my_role_detail',
  #   title: 'i18n.label.title', # this is passed to the t() function - can be plain text
  #   path:  'admin_my_role_details_path'
  # }

  # Add new resource to design
  # config.design_resources << {
  #   name: 'my_role_detail',
  #   title: 'i18n.label.title', # this is passed to the t() function - can be plain text
  #   path:  'admin_my_role_details_path'
  # }

end
