require "spec_helper"

describe Company do
  it { should belong_to :user_detail }
  it { should have_many :positions }
  it { should have_many :contacts }
  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_most(32)}
end
