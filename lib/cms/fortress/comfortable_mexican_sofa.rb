ComfortableMexicanSofa.configure do |config|
  config.admin_auth = 'Cms::Fortress::Auth'
end

ComfortableMexicanSofa::ViewHooks.add(:header, 'cms/fortress/shared/admin_topnav')
#   ComfortableMexicanSofa::ViewHooks.add(:navigation, '/layouts/admin/navigation')
#   ComfortableMexicanSofa::ViewHooks.add(:html_head, '/layouts/admin/html_head')
#   ComfortableMexicanSofa::ViewHooks.add(:page_form, '/layouts/admin/page_form')
