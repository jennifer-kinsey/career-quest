class UserDetail < ActiveRecord::Base
  belongs_to :user_credential

  has_many :positions
  has_many :correspondences
  has_many :contacts
  has_many :companies
end
