class User < ApplicationRecord
   has_many :posts, dependent: :destroy

   
   validates :name, 
   presence: true,
   length: { maximum: 20 },
   uniqueness: true
   
   has_secure_password
   validates :password,presence: true, length: { minimum: 6 },allow_nil: true

def feed
    Post.where("user_id = ?", id)
  end


end
