class Category < ActiveRecord::Base
  has_many :adverts
  validates :name, presence: true, length: { maximum: 50 }
  validates :name, uniqueness: true
end
