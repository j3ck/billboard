class Advert < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :category
  belongs_to :type
  has_many :images, dependent: :destroy

  aasm column: :state do
    state :template, initial: true
    state :moderated
    state :rejected
    state :published
    state :archive

    event :moderate do
      transitions from: :template, to: :moderated
    end

    event :rejected do
      transitions from: :moderated, to: :rejected
    end

    event :publish do
      transitions from: :moderated, to: :published
    end

    event :in_archive do
      transitions from: [:published, :rejected, :moderated ], to: :archive
    end

    event :nevest do
      transitions from: [:published, :rejected, :moderated, :archive], to: :template
    end
  end
end
