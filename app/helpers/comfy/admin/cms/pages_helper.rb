module Comfy::Admin::Cms::PagesHelper
  def page_actions(page)
    events = page.aasm.events(permitted: true).map(&:name)
    events.select! do |event|
      can?(:manage, 'contents.page.' + event.to_s)
    end
    events
  end

  def cached_timeout_for_select
    {
        "Uncached" => 0,
        "15 minutes" => 15.minutes,
        "30 minutes" => 30.minutes,
        "1 hour" => 1.hour,
        "3 hours" => 3.hours,
        "24 hours" => 1.day,
        "15 days" => 15.days,
        "30 days" => 30.days
    }.map {|k,v| [k, v.to_i] }
  end

  def site_selector
    select_tag(
        :sites,
        options_for_select(sites_for_select, params[:site_id]),
        {class: 'form-control input-sm site_selector', id: 'js_site_selector'}
    )
  end

  def sites_for_select
    all_sites.map { |site| [site.label, site.id] }
  end

  def all_sites
    Comfy::Cms::Site.all
  end

  def multiple_sites?
    all_sites.size > 1
  end
end
