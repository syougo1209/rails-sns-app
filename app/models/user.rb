class User < ApplicationRecord
   validates :name, 
   presence: true,
   length: { maximum: 20 },
   uniqueness: true
   
   has_secure_password
  validates :password, length: { minimum: 6 }

end
