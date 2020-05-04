class Post < ApplicationRecord
  belongs_to :user
  #いいねの設定
  has_many :likes, dependent: :destroy
  has_many :like_people, through: :likes, source: :user
   
   
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  
  validates :user_id, presence:true
  validates :content, presence: true, length: { maximum: 140 }
  validates :title,   presence:true, length: { maximum: 50 }
  validate  :picture_size

private
def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
