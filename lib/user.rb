class UserCredential < ActiveRecord::Base
  belongs_to :user_details

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end

class UserDetail < ActiveRecord::Base
  belongs_to :user_credentials
  belongs_to :positions
  belongs_to :correspondences
  has_many :contacts, through: :correspondences
  has_many :companies, through: :positions
end
