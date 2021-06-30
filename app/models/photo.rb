class Photo < ApplicationRecord
  belongs_to :folder
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  
  validates :image, presence: true
  
  validates :date, presence: true
  
mount_uploader :image, ImageUploader
  
end
