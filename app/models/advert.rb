class Advert < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :type
  has_many :images, dependent: :destroy
end
