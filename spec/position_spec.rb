require "spec_helper"

describe Position do
  it { should belong_to :user_detail }
  it { should belong_to :company }
  it { should have_many :correspondences}
end
