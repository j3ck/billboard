class Log < ActiveRecord::Base
  belongs_to :advert

  default_scope { order(created_at: :desc) }

  validates :comment, presence: true, length: { maximum: 500 }
end
