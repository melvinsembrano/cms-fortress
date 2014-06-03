module Cms
  module Fortress
    module PageMethods

      def self.included(base)

        base.class_eval do
          include AASM

          aasm do
            state :drafted, initial: true
            state :reviewed
            state :scheduled
            state :published

            event :review do
              transitions from: :drafted, to: :reviewed
            end

            event :schedule do
              after :publish_page?
              transitions from: [:drafted, :reviewed], to: :scheduled, guard: :published_date?
            end

            event :publish do
              after :publish_page?
              transitions from: [:drafted, :reviewed, :scheduled], to: :published
            end

            event :draft do
              after :publish_page?
              transitions from: [:reviewed, :scheduled, :published], to: :drafted
            end
          end

          def publish_page?
            ret = false
            if self.published?
              ret = true
            else
              if self.scheduled? && self.published_date.present? <= Date.today
                ret = true
              end
            end
            ret
          end

          scope :drafts, -> { joins(:page_workflow).where(cms_page_workflows: {status_id: 0}) }
          scope :reviewed, -> { joins(:page_workflow).where(cms_page_workflows: {status_id: 1}) }

        end

      end

    end
  end
end
