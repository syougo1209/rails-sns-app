class User < ApplicationRecord
   has_many :posts, dependent: :destroy
   has_many :active_relationships,class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
    has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  #いいねの設定
   has_many :likes, dependent: :destroy
   has_many :like_posts, through: :likes, source: :post
   #コメント
    has_many :comments, dependent: :destroy 
    #DM
    has_many :entries, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :rooms, through: :entries, source: :room
   
   mount_uploader :picture, PictureUploader
   validates :name, 
   presence: true,
   length: { maximum: 20 }
   #uniqueness: true
   
   has_secure_password
   validates :password,presence: true, length: { minimum: 6 },allow_nil: true

 def feed
   following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)

 end

def follow(other_user)
  following << other_user  
end

def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user).destroy
end

def follow?(other_user)
    following.include?(other_user)
end

def favorite(favorite_post)
    like_posts << favorite_post
end

def unfavorite(favorite_post)
    likes.find_by(post_id: favorite_post).destroy
end

def favorite?(favorite_post)
 like_posts.include?(favorite_post)
end

 def self.search(search,prefecture) 
     if search && prefecture!="都道府県を選択出来ます" && prefecture
       where(['name LIKE ?', "%#{search}%"]).where(prefecture: prefecture) 
     elsif prefecture!="都道府県を選択出来ます" && prefecture
       where("prefecture=:prefecture", prefecture: prefecture)
     elsif search && prefecture=="都道府県を選択出来ます" && prefecture
       where(['name LIKE ?', "%#{search}%"])
     end
 end
end
