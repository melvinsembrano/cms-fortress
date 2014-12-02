module Cms
  module Fortress
    module PageMethods

      def self.included(base)

        base.extend ClassMethods

        base.class_eval do
          before_create { self.draft if self.new? }

          include AASM

          aasm do
            state :new, initial: true
            state :drafted
            state :reviewed
            state :scheduled
            state :published, before_enter: :check_publish_date

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

          def check_publish_date
            self.published_date = Time.now unless self.published_date
          end

          def publish_page?
            ret = false
            if self.published?
              ret = true
            else
              if self.scheduled? && self.published_date.present? && self.published_date <= Date.today
                ret = true
              end
            end
            self.is_published = ret
          end

        end

      end

        module ClassMethods
          def updated_scheduled

          end
        end


    end
  end
end
