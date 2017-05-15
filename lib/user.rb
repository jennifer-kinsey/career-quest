class UserCredential < ActiveRecord::Base
  belongs_to :user_detail
end

class UserDetail < ActiveRecord::Base
  belongs_to :user_credential
  belongs_to :position
  belongs_to :correspondence
  has_many :contacts, through: :correspondence
  has_many :companies, through: :position
end
