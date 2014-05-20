class Cms::PageWorkflow < ActiveRecord::Base
  self.table_name = 'cms_page_workflows'

  belongs_to :page, :class_name => 'Comfy::Cms::Page', :foreign_key => 'cms_page_id'

  after_save do |record|
    record.page.update_attribute(:is_published, record.page_published?)
  end

  def self.statuses
    {
      0 => :draft,
      1 => :reviewed,
      # 2 => :scheduled,
      3 => :published
    }
  end

  def self.statuses_for_select(can_publish, can_review)
    ret = [["Draft", 0]]
    ret << ["Reviewed", 1] if can_review
    ret << ["Published", 3] if can_publish
    # self.statuses.map {|k,v| [v.to_s.titleize, k]}
    ret
  end

  def self.cached_timeout_for_select
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

  def page_published?
    (status_id.eql?(3) || status_id.eql?(2)) && published_date <= Date.today
  end

end
