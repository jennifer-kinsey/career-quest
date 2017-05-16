class UserCredential < ActiveRecord::Base

 belongs_to :user_detail
 has_secure_password
 validates :name, presence: true
 validates :email, presence: true, uniqueness: true
 validates :password_digest, presence: true
 validates :password, confirmation: true
end

class UserDetail < ActiveRecord::Base
  belongs_to :user_credential
  belongs_to :position
  belongs_to :correspondence
  has_many :contacts, through: :correspondence
  has_many :companies, through: :position

  validates(:name, {presence: true, length: { maximum: 32}})
end
