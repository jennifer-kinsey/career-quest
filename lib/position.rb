class Position < ActiveRecord::Base
  belongs_to :user_details
  belongs_to :companies
  belongs_to :correspondences
end
