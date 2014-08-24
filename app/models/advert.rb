class Advert < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :category
  belongs_to :type
  has_many :images, dependent: :destroy

  aasm column: :state do
    state :template, initial: true
    state :moderated
    state :accepted
    state :rejected
    state :published
    state :archived

    event :moderate do
      transitions from: :template, to: :moderated
    end

    event :reject do
      transitions from: :moderated, to: :rejected
    end

    event :accept do
      transitions from: :moderated, to: :accepted
    end

    event :publish do
      transitions from: :accepted, to: :published
    end

    event :archive do
      transitions from: :published, to: :archived
    end

    event :newest do
      transitions from: [:published, :rejected, :moderated, :archived], to: :template
    end
  end
end
