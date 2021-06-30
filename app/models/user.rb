class User < ApplicationRecord
      before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :folders, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :folder
  

  
  def favorite(other_folder)
      self.favorites.find_or_create_by(folder_id: other_folder.id)
  end
  
  def unfavorite(other_folder)
    favorite = self.favorites.find_by(folder_id: other_folder.id)
    favorite.destroy if favorite
  end
  
  def favorites?(other_folder)
    self.likes.include?(other_folder)
  end
  
end