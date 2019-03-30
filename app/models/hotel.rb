class Hotel < ApplicationRecord
  validates :no, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :information_url, presence: true, length: { maximum: 255 }
  validates :kananame, presence: true, length: { maximum: 255 }
  validates :min_charge, presence: true, length: { maximum: 255 }
  validates :special, presence: true, length: { maximum: 255 }
  validates :address1, presence: true, length: { maximum: 255 }
  validates :address2, presence: true, length: { maximum: 255 }  
  validates :access, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  validates :thumbnail_url, presence: true, length: { maximum: 255 }
  validates :review_count, presence: true, length: { maximum: 255 }
  validates :review_average, presence: true, length: { maximum: 255 }
  validates :meal_average, presence: true, length: { maximum: 255 }

  has_many :favorites
  has_many :users, through: :favorites  
end
