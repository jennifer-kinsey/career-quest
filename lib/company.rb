class Company < ActiveRecord::Base
  belongs_to :position
  has_many :user_details, through: :position
end
