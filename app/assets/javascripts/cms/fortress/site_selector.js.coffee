class SiteSelector
  constructor: ->
    @initialize_event_handler()

  initialize_event_handler: ->
    @site_selector()

  site_selector: ->
    ($ '#js_site_selector').on 'change', (event) =>
      page_id       = ($ event.target).val()
      locale        =  location.search
      location.href = "/cms-admin/sites/#{page_id}/pages#{locale}"

$ ->
  site_selector = new SiteSelector
