class Category < ActiveRecord::Base
  has_many :adverts

  scope :recent, -> { order(created_at: :desc) }

  validates :name, presence: true, length: { maximum: 50 }
  validates :name, uniqueness: true
end
