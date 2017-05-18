class Contact < ActiveRecord::Base
  belongs_to :user_detail
  belongs_to :company

  has_many :correspondences
  has_many :tweets

  validates(:name, {presence: true, case_sensitive: false, length: { maximum: 32}})
end
