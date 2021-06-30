class Folder < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  

  
  has_many :favorites, dependent: :destroy
  has_many :addlikes, through: :favorites, source: :user, dependent: :destroy
  def self.search(search)
    if search
      where(['username LIKE ?', "%#{search}%"])
    else
      all
    end
  end
end
