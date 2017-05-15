class UserCredential < ActiveRecord::Base
  belongs_to :user_details
end

class UserDetail < ActiveRecord::Base
  belongs_to :user_credentials
  belongs_to :positions
  belongs_to :correspondences
  has_many :contacts, through: :correspondences
  has_many :companies, through: :positions
end
