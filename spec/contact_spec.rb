require "spec_helper"

describe Contact do
  it { should belong_to :user_detail }
  it { should belong_to :company }
  it { should have_many :correspondences }
  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_most(32)}
end
