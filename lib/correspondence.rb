class Correspondence < ActiveRecord::Base
  belongs_to :user_detail
  belongs_to :contact
  belongs_to :position
  belongs_to :company
end
