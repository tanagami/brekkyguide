class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :favorites
  has_many :hotels, through: :favorites
  
  def like(hotel)
    favorites.find_or_create_by(hotel_id: hotel.id)
  end
  
  def unlike(hotel)
    like = favorites.find_by(hotel_id: hotel.id)
    like.destroy if like
  end
  
  def like?(hotel)
    self.hotels.include?(hotel)
  end
end
