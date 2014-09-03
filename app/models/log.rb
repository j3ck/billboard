class Log < ActiveRecord::Base
  belongs_to :advert

  validates :comment, presence: true, length: { maximum: 500 }
end
