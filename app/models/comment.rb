class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    
    default_scope -> { order(created_at: :desc) }
    validates :content, presence: true,length: { maximum: 50 }
    validates :user_id, presence: true
    validates :post_id, presence: true
    
end
