class Company < ActiveRecord::Base
  belongs_to :user_detail

  has_many :positions, dependent: :destroy
  has_many :contacts
  has_many :correspondences

  validates(:name, {presence: true, uniqueness: {scope: :user_detail_id}, length: { maximum: 32}})

  before_destroy :destroy_positions

private

  def destroy_positions
    self.positions.delete_all
  end

end
