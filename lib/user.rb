class UserCredential < ActiveRecord::Base
 belongs_to :user_detail
 validates :name, presence: true
 validates :email, presence: true, uniqueness: true
 validates :password_digest, presence: true
end

class UserDetail < ActiveRecord::Base
  belongs_to :user_credential
  belongs_to :position
  belongs_to :correspondence
  has_many :contacts, through: :correspondence
  has_many :companies, through: :position
end
