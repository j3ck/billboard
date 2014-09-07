class Advert < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :category, counter_cache: true
  belongs_to :type
  has_many :images, dependent: :destroy
  has_many :logs, dependent: :destroy

  scope :stated, -> state { includes(:category, :type).
                                  where(state: state).
                                  order(updated_at: :desc) }

  validates :title, :category_id, :description, :user_id, :type_id, :state, presence: true
  validates :title, length: { maximum: 100 }
  validates :price, numericality: true

  aasm column: :state do
    state :template, initial: true
    state :moderated
    state :rejected
    state :published
    state :archived

    event :moderate do
      transitions from: :template, to: :moderated
    end

    event :reject do
      transitions from: :moderated, to: :rejected
    end

    event :publish do
      transitions from: :moderated, to: :published
    end

    event :archive do
      transitions from: :published, to: :archived
    end

    event :newest do
      transitions from: [:published, :rejected, :moderated, :archived, :template], to: :template
    end
  end

  def self.to_archive_old_adverts
    @adverts = Advert.where('state = ? AND updated_at <= ?', 'published', 1.day.ago)
    @adverts.find_each do |advert|
      advert.archive!
    end
  end

  private
    ransacker :category_id do
      Arel::Nodes::SqlLiteral.new("to_char(\"#{table_name}\".\"category_id\", '99999')")
    end

    ransacker :type_id do
      Arel::Nodes::SqlLiteral.new("to_char(\"#{table_name}\".\"type_id\", '99999')")
    end
end
