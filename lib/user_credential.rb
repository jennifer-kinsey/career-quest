class UserCredential < ActiveRecord::Base
  belongs_to :user_detail
  before_save do
    email.downcase!
  end

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 6}
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  private

end
