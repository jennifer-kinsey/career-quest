class Company < ActiveRecord::Base
  belongs_to :positions
  has_many :user_details, through: :positions
end
