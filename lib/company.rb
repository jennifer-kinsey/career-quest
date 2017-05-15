class Company < ActiveRecord::Base
  belongs_to :position
  has_many :user_details, through: :position
  validates(:name, {presence: true, case_sensitive: false, length: { maximum: 32}})
end
