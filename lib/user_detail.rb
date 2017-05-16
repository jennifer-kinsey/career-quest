class UserDetail < ActiveRecord::Base
  belongs_to :user_credential
  belongs_to :position
  belongs_to :correspondence
  has_many :contacts, through: :correspondence
  has_many :companies, through: :position

  validates(:name, {presence: true, length: { maximum: 32}})
end
