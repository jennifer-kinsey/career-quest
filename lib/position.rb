class Position < ActiveRecord::Base
  belongs_to :user_detail
  belongs_to :company
  belongs_to :correspondence
end
