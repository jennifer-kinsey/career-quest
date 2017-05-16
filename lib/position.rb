class Position < ActiveRecord::Base
  belongs_to :user_detail
  belongs_to :company
  
  has_many :correspondences
end
