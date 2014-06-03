module Comfy::Admin::Cms::PagesHelper
  def page_actions(page)
    states = page.aasm.permissible_events
    states.select! do |state|
      can?(:manage, 'contents.page.'+state.to_s)
    end
    states
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
end
