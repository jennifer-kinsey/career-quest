class Company < ActiveRecord::Base
  belongs_to :user_detail

  has_many :positions, dependent: :destroy
  has_many :contacts

  validates(:name, {presence: true, case_sensitive: false, length: { maximum: 32}})

  before_destroy :destroy_positions

private

  def destroy_positions
    self.positions.delete_all
  end
end
