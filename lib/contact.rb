class Contact < ActiveRecord::Base
  belongs_to :company
  belongs_to :correspondence
  has_many :user_details, through: :correspondence
end
