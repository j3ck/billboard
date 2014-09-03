class Log < ActiveRecord::Base
  belongs_to :advert

  validates :comment, presence: true
end
