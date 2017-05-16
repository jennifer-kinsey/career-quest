class Company < ActiveRecord::Base
  belongs_to :user_detail

  has_many :positions
  has_many :contacts
  
  validates(:name, {presence: true, case_sensitive: false, length: { maximum: 32}})
end
