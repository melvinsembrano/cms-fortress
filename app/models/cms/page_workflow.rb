class Cms::PageWorkflow < ActiveRecord::Base
  self.table_name = 'cms_page_workflows'

  belongs_to :page, :foreign_key => 'cms_page_id'

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

  def self.statuses_for_select
    self.statuses.map {|k,v| [v.to_s.titleize, k]}
  end

  def page_published?
    status_id.eql?(3) || status_id.eql?(2) && published_date < Time.now
  end

end
