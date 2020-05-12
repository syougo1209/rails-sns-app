class Post < ApplicationRecord
  belongs_to :user
  #いいねの設定
  has_many :likes, dependent: :destroy
  has_many :like_people, through: :likes, source: :user
  has_many :comments, dependent: :destroy 
   
  mount_uploader :picture, PictureUploader
  
  validates :user_id, presence:true
  validates :content, presence: true, length: { maximum: 140 }
  validates :title,   presence: true, length: { maximum: 50 }
  validate  :picture_size

  def self.search(search,prefecture) 
     if search && prefecture
       where(['content LIKE ?', "%#{search}%"]).where(['address LIKE ?', "%#{prefecture}%"])  
     elsif search
       where(['content LIKE ?', "%#{search}%"])
     elsif prefecture
         where(['address LIKE ?', "%#{prefecture}%"]) 
     end
 end
 
 def self.ranking(search,prefecture)
  if search!="すべての月" && prefecture!="都道府県を選択出来ます" && search && prefecture
    Post.joins(:likes)
    .group(:post_id)
    .where(['address LIKE ?', "%#{prefecture}%"])
    .where(['created_date LIKE ?', "%#{search}%"])
    .order('count(post_id) desc')
    .order('created_at desc')
  elsif search!="すべての月" && prefecture=="都道府県を選択出来ます" && search && prefecture
      Post.joins(:likes)
    .group(:post_id)
    .where(['created_date LIKE ?', "%#{search}%"])
    .order('count(post_id) desc')
    .order('created_at desc')
  elsif search=="すべての月" && prefecture!="都道府県を選択出来ます" && search && prefecture
    Post.joins(:likes)
    .group(:post_id)
    .where(['address LIKE ?', "%#{prefecture}%"])
    .order('count(post_id) desc')
    .order('created_at desc')
  else
      Post.find(Like.group(:post_id).order('count(post_id) desc').order('created_at desc').limit(10).pluck(:post_id))
  end
  end
 
private
def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
