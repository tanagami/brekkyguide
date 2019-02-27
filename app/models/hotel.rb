class Hotel < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :kananame, presence: true, length: { maximum: 255 }
  validates :special, presence: true, length: { maximum: 255 }
  validates :address1, presence: true, length: { maximum: 255 }
  validates :address2, presence: true, length: { maximum: 255 }  
  validates :access, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  validates :thumbnail_url, presence: true, length: { maximum: 255 }
  validates :review_count, presence: true, length: { maximum: 255 }
  validates :review_average, presence: true, length: { maximum: 255 }
  validates :meal_average, presence: true, length: { maximum: 255 }
  validates :breakfast_place, length: { maximum: 255 }
end
