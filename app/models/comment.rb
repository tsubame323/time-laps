class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  belongs_to :folder
  validates :content, presence: true, length: { maximum: 255 }
end
