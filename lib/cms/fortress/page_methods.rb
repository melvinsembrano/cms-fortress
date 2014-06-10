module Cms
  module Fortress
    module PageMethods

      def self.included(base)

        base.class_eval do
          include AASM

          aasm do
            state :new, initial: true
            state :drafted
            state :reviewed
            state :scheduled
            state :published

            event :draft do
              after :publish_page?
              transitions from: :new, to: :drafted
            end

            event :review do
              after :publish_page?
              transitions from: [:new, :drafted], to: :reviewed
            end

            event :schedule do
              after :publish_page?
              transitions from: [:new, :drafted, :reviewed], to: :scheduled, guard: :published_date?
            end

            event :publish do
              after :publish_page?
              transitions from: [:new, :drafted, :reviewed, :scheduled], to: :published
            end

            event :reset do
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
            self.is_published = ret
          end

        end

      end

    end
  end
end
