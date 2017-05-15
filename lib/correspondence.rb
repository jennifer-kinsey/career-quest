class Correspondence < ActiveRecord::Base
  belongs_to :user_details
  belongs_to :contacts
  belongs_to :positions
end
