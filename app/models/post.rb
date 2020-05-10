class Post < ApplicationRecord
  belongs_to :user
  #いいねの設定
  has_many :likes, dependent: :destroy
  has_many :like_people, through: :likes, source: :user
  has_many :comments, dependent: :destroy 
   
  mount_uploader :picture, PictureUploader
  
  validates :user_id, presence:true
  validates :content, presence: true, length: { maximum: 140 }
  validates :title,   presence:true, length: { maximum: 50 }
  validate  :picture_size

  def self.search(search) 
     if search
       where(['content LIKE ?', "%#{search}%"]) 
     else
       all.take(10)
    end
 end
 
 def self.ranking(search)
  if search && search!="すべての月"
    Post.joins(:likes).group(:post_id).where(['created_date LIKE ?', "%#{search}%"]).order('count(post_id) desc')
  else
    Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end
  end
 
private
def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
