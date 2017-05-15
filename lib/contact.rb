class Contact < ActiveRecord::Base
  belongs_to :company
  belongs_to :correspondence
  has_many :user_details, through: :correspondence
  validates(:name, {presence: true, case_sensitive: false, length: { maximum: 32}})
end
