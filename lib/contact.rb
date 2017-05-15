class Contact < ActiveRecord::Base
  belongs_to :companies
  has_many :user_details, through: :correspondences
end
