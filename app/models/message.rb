class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
   validates :content,presence: true, length: { maximum: 100 }
   validates :user_id,presence: true
   validates :room_id,presence: true
end
