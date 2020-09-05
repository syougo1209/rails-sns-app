class Tag < ApplicationRecord
    belongs_to :user
    validates :user_id, presence: true, uniqueness: { scope: :tag_name }
    validates :tag_name, presence: true, length: {maximum: 20}
    default_scope -> { order(created_at: :desc) }
end
